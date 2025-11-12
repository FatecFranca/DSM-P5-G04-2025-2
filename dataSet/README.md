# Modelo de Classificação de Nível de Estresse

Este diretório contém os scripts e os artefatos para um modelo de Machine Learning que prevê o nível de estresse de um usuário com base em seus hábitos de consumo de café e estilo de vida.

## Objetivo do Modelo

O objetivo é classificar o nível de estresse de um usuário em uma de três categorias: **Baixo**, **Médio** ou **Alto**, a partir de dados fornecidos pelo usuário.

## Pipeline de Treinamento (Scripts Python)

O processo de criação do modelo foi atualizado para usar scripts Python puros, o que garante maior robustez e facilidade de execução. Os scripts estão localizados na pasta `treinamento_AM/` e devem ser executados na ordem:

1.  **`1_preprocess.py`**
    *   **Função:** Carrega o dataset bruto, realiza uma limpeza completa, converte dados de texto para números, trata valores ausentes, remove outliers e normaliza os dados.
    *   **Saída:** Gera um arquivo limpo chamado `processed_coffee_data.csv` nesta pasta.

2.  **`2_train.py`**
    *   **Função:** Carrega os dados processados, treina 6 diferentes algoritmos de classificação e os compara.
    *   **Saída:** Imprime a acurácia de cada modelo no console e salva um gráfico `model_comparison.png` com a comparação visual.

3.  **`3_save_model.py`**
    *   **Função:** Pega o melhor modelo identificado (SVM), treina-o com **todos** os dados disponíveis e salva os artefatos finais.
    *   **Saída:** Os dois arquivos necessários para a integração (`modelo_estresse.joblib` e `scaler_estresse.joblib`).

## Artefatos Finais

Os seguintes arquivos foram gerados nesta pasta e são os únicos necessários para usar o modelo em produção:

*   **`modelo_estresse.joblib`**: O modelo de classificação (SVM) treinado.
*   **`scaler_estresse.joblib`**: O objeto `StandardScaler` (normalizador) treinado. **É essencial para a predição.**

---

## Guia de Integração (Backend Node.js)

Para usar o modelo na sua aplicação, a API backend (Node.js) deve chamar um script Python que executa a previsão.

### 1. Script de Previsão (`predict.py`)

Um script chamado `predict.py` foi criado em `treinamento_AM/`. Ele foi projetado para receber os dados de um usuário via argumento de linha de comando, carregar os artefatos, fazer a previsão e imprimir o resultado em JSON.

### 2. Exemplo de Controller em Node.js

Aqui está um exemplo de como sua API Node.js pode chamar o script `predict.py` usando `child_process`. Você pode criar um novo arquivo de rota e um controller para essa funcionalidade.

```javascript
// Exemplo: predictController.js
const { spawn } = require('child_process');

const predictStressLevel = (req, res) => {
    // 1. Obter os dados do usuário do corpo da requisição
    // Ex: { Age: 35, Coffee_Intake: 4, ... }
    const userData = req.body;

    // Converte o objeto de dados do usuário em uma string JSON
    const userDataString = JSON.stringify(userData);

    // 2. Chamar o script Python como um processo filho
    // O primeiro argumento é o executável python da venv (ou um 'python' global)
    // O segundo é um array com o caminho do script e os argumentos
    const pythonProcess = spawn('python3', [
        'dataSet/treinamento_AM/predict.py',
        userDataString
    ]);

    let predictionResult = '';
    let errorData = '';

    // 3. Capturar a saída do script Python
    pythonProcess.stdout.on('data', (data) => {
        predictionResult += data.toString();
    });

    // Capturar qualquer erro do script
    pythonProcess.stderr.on('data', (data) => {
        errorData += data.toString();
    });

    // 4. Enviar a resposta quando o script terminar
    pythonProcess.on('close', (code) => {
        if (code !== 0 || errorData) {
            console.error(`Python script exited with code ${code}`);
            console.error('Error data:', errorData);
            return res.status(500).json({ 
                message: "Erro ao processar a previsão.",
                error: errorData 
            });
        }

        try {
            const result = JSON.parse(predictionResult);
            if (result.error) {
                 return res.status(400).json({ message: result.error });
            }
            // Envia o resultado da previsão de volta para o frontend
            return res.status(200).json(result);
        } catch (e) {
            return res.status(500).json({ 
                message: "Erro ao parsear o resultado da previsão.",
                rawOutput: predictionResult 
            });
        }
    });
};

module.exports = {
    predictStressLevel,
};
```

### Resumo do Fluxo de Integração:

1.  **Frontend:** Envia os dados do formulário para `POST /api/predict`.
2.  **Backend (Node.js):** O `predictController` recebe os dados.
3.  **Backend (Node.js):** Chama `predict.py`, passando os dados do usuário como uma string JSON.
4.  **Backend (Python):** `predict.py` carrega o modelo, processa os dados e imprime o resultado em JSON.
5.  **Backend (Node.js):** Captura a saída do script Python e a envia como resposta para o frontend.
6.  **Frontend:** Exibe o resultado recebido.
