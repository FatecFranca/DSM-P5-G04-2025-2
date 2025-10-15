const Form = require('../models/form');

const createForm = async (req, res) => {
    try {
        const { 
            Idade, Genero, Pais, xicarasDiaCafe, cafeinaEstimada, 
            horasSono, qualidadeDeSono, IMC, frequenciaCardio, 
            problemasDeSaude, atvFisicaSemanalHrs, Ocupacao, Fuma, Alcool 
        } = req.body;

        const idUsuario = req.user.id; // ID do usuário vindo do token JWT (authMiddleware)

        const novoForm = await Form.create({
            Id_usuario: idUsuario,
            Idade, Genero, Pais, xicarasDiaCafe, cafeinaEstimada,
            horasSono, qualidadeDeSono, IMC, frequenciaCardio,
            problemasDeSaude, atvFisicaSemanalHrs, Ocupacao, Fuma, Alcool
        });

        res.status(201).json(novoForm);
    } catch (error) {
        res.status(500).json({ error: 'Erro ao criar formulário', details: error.message });
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
