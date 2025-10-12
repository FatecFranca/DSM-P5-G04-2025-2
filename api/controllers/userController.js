const User = require('../models/user');
const bcrypt = require('bcrypt');

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

// Obter um usuário pelo ID
const getUserById = async (req, res) => {
    try {
        const { id } = req.params;
        const user = await User.findByPk(id, {
            attributes: { exclude: ['Senha'] }
        });

        if (!user) {
            return res.status(404).json({ error: 'Usuário não encontrado' });
        }

        res.status(200).json(user);
    } catch (error) {
        res.status(500).json({ error: 'Erro ao buscar usuário', details: error.message });
    }
};

// Atualizar um usuário
const updateUser = async (req, res) => {
    try {
        const { id } = req.params;
        const { Nome, 'E-mail': Email, Cep, data_nasc, Senha } = req.body;

        const user = await User.findByPk(id);

        if (!user) {
            return res.status(404).json({ error: 'Usuário não encontrado' });
        }

        // Atualiza os campos fornecidos
        if (Nome) user.Nome = Nome;
        if (Email) user['E-mail'] = Email;
        if (Cep) user.Cep = Cep;
        if (data_nasc) user.data_nasc = data_nasc;

        // Se uma nova senha for fornecida, hasheia e atualiza
        if (Senha) {
            user.Senha = await bcrypt.hash(Senha, 10);
        }

        await user.save();

        const userResponse = user.toJSON();
        delete userResponse.Senha;

        res.status(200).json(userResponse);
    } catch (error) {
        res.status(500).json({ error: 'Erro ao atualizar usuário', details: error.message });
    }
};

module.exports = {
    createUser,
    getAllUsers,
    getUserById,
    updateUser
};
