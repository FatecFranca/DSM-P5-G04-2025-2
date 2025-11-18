const Form = require('../models/form');
const { spawn } = require('child_process');
const path = require('path');

// Função auxiliar para chamar o script Python
const getPrediction = (data) => {
    return new Promise((resolve, reject) => {
        // O script espera os dados como uma string JSON no primeiro argumento
        const dataString = JSON.stringify(data);
        
        // Caminho para o script Python
        const scriptPath = path.join(__dirname, '..', '..', 'dataSet', 'treinamento_AM', 'predict.py');
        // Diretório raiz do projeto, para que o script encontre o modelo .joblib
        const projectRoot = path.join(__dirname, '..', '..');

        const pythonExecutable = path.join(projectRoot, 'venv', 'bin', 'python3');

        // Spawns the python script using the virtual environment's executable
        const pythonProcess = spawn(pythonExecutable, [scriptPath, dataString], { cwd: projectRoot });

        let result = '';
        let error = '';

        pythonProcess.stdout.on('data', (data) => {
            result += data.toString();
        });

        pythonProcess.stderr.on('data', (data) => {
            error += data.toString();
        });

        pythonProcess.on('close', (code) => {
            // Log da saída bruta para depuração
            console.log(`Python script stdout: ${result}`);
            console.error(`Python script stderr: ${error}`);

            if (code !== 0) {
                console.error(`Python script exited with code ${code}`);
                return reject(new Error('Erro no script de previsão.'));
            }
            try {
                const predictionResult = JSON.parse(result);
                // Verifica se o script retornou um erro interno
                if (predictionResult.error) {
                    console.error("Erro retornado pelo script Python:", predictionResult.error);
                    return reject(new Error(predictionResult.error));
                }
                resolve(predictionResult);
            } catch (e) {
                console.error("Falha ao decodificar JSON da predição:", result);
                reject(new Error('Resposta inválida do script de previsão.'));
            }
        });
    });
};


const createForm = async (req, res) => {
    try {
        const { 
            Idade, Genero, xicarasDiaCafe, 
            horasSono, qualidadeDeSono, IMC, frequenciaCardio, 
            problemasDeSaude, atvFisicaSemanalHrs, Ocupacao, Fuma, Alcool 
        } = req.body;

        const idUsuario = req.user.id;

        const novoForm = await Form.create({
            Id_usuario: idUsuario,
            Idade, Genero, xicarasDiaCafe,
            horasSono, qualidadeDeSono, IMC, frequenciaCardio,
            problemasDeSaude, atvFisicaSemanalHrs, Ocupacao, 
            Fuma,
            Alcool
        });

        // Mapeamento de dados para o script Python
        const predictionData = {
            "Age": Idade,
            "Gender": Genero === 'Masculino' ? 'Male' : (Genero === 'Feminino' ? 'Female' : 'Other'),
            "Coffee_Intake": xicarasDiaCafe,
            "Caffeine_mg": xicarasDiaCafe * 90, // Estimativa de 90mg por xícara
            "Sleep_Hours": horasSono,
            "Sleep_Quality": qualidadeDeSono,
            "BMI": IMC,
            "Heart_Rate": frequenciaCardio,
            "Physical_Activity_Hours": atvFisicaSemanalHrs,
            "Smoking": Fuma ? 1 : 0,
            "Alcohol_Consumption": Alcool ? 1 : 0,
            // O script espera o país e a ocupação para o One-Hot Encoding
            "Country": "Brazil", // Assumindo Brasil como padrão
            "Health_Issues": problemasDeSaude === 'Excelente' || problemasDeSaude === 'Boa' ? 'None' : 'Mild', // Simplificação
            "Occupation": Ocupacao === 'Estudante' ? 'Student' : (Ocupacao === 'Autônomo' ? 'Service' : 'Other') // Simplificação
        };

        // Chama o script de previsão
        const prediction = await getPrediction(predictionData);

        // Retorna tanto o formulário criado quanto a previsão
        res.status(201).json({
            form: novoForm,
            prediction: prediction
        });

    } catch (error) {
        console.error('Erro detalhado:', error);
        res.status(500).json({ error: 'Erro ao criar formulário ou ao obter previsão.', details: error.message });
    }
};

const getForm = async (req, res) => {
    try {
        const idUsuario = req.user.id;
        const form = await Form.findOne({ where: { Id_usuario: idUsuario } });

        if (!form) {
            return res.status(404).json({ error: 'Formulário não encontrado' });
        }

        res.status(200).json(form);
    } catch (error) {
        res.status(500).json({ error: 'Erro ao buscar formulário', details: error.message });
    }
};

const updateForm = async (req, res) => {
    try {
        const idUsuario = req.user.id;
        
        // Garante que Fuma e Alcool sejam tratados como booleans se existirem no corpo da requisição
        if (req.body.Fuma !== undefined) {
            req.body.Fuma = Boolean(req.body.Fuma);
        }
        if (req.body.Alcool !== undefined) {
            req.body.Alcool = Boolean(req.body.Alcool);
        }

        const [updated] = await Form.update(req.body, {
            where: { Id_usuario: idUsuario }
        });

        if (updated) {
            const updatedForm = await Form.findOne({ where: { Id_usuario: idUsuario } });
            res.status(200).json(updatedForm);
        } else {
            res.status(404).json({ error: 'Formulário não encontrado para atualização' });
        }
    } catch (error) {
        res.status(500).json({ error: 'Erro ao atualizar formulário', details: error.message });
    }
};

module.exports = {
    createForm,
    getForm,
    updateForm
};
