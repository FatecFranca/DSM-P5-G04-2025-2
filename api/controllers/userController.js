const User = require('../models/user');

// Criar um novo usuário
const createUser = async (req, res) => {
    try {
        const { Nome, CPF, 'E-mail': Email, Senha, Cep, data_nasc } = req.body;

        // Validação básica
        if (!Nome || !CPF || !Email || !Senha || !Cep || !data_nasc) {
            return res.status(400).json({ error: 'Todos os campos são obrigatórios' });
        }

        // Verificar se usuário já existe
        const existingUser = await User.findOne({ where: { CPF } });
        if (existingUser) {
            return res.status(409).json({ error: 'Usuário com este CPF já existe' });
        }

        const newUser = await User.create({ Nome, CPF, 'E-mail': Email, Senha, Cep, data_nasc });
        
        // Não retornar a senha na resposta
        const userResponse = newUser.toJSON();
        delete userResponse.Senha;

        res.status(201).json(userResponse);
    } catch (error) {
        res.status(500).json({ error: 'Erro ao criar usuário', details: error.message });
    }
};

// Obter todos os usuários
const getAllUsers = async (req, res) => {
    try {
        const users = await User.findAll({
            attributes: { exclude: ['Senha'] } // Excluir o campo Senha
        });
        res.status(200).json(users);
    } catch (error) {
        res.status(500).json({ error: 'Erro ao buscar usuários', details: error.message });
    }
};

module.exports = {
    createUser,
    getAllUsers
};
