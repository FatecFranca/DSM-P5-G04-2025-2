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

module.exports = {
    createForm
};
