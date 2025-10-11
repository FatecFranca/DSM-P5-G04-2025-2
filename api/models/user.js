const { DataTypes } = require('sequelize');
const sequelize = require('../database/connection');
const bcrypt = require('bcrypt');

const User = sequelize.define('Usuario', {
    Id_usuario: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    Nome: {
        type: DataTypes.STRING(100),
        allowNull: false
    },
    CPF: {
        type: DataTypes.STRING(14),
        allowNull: false,
        unique: true
    },
    'E-mail': { // Sequelize pode lidar com nomes de colunas especiais
        type: DataTypes.STRING(100),
        allowNull: false,
        unique: true,
        validate: {
            isEmail: true
        }
    },
    Senha: {
        type: DataTypes.STRING,
        allowNull: false
    },
    Cep: {
        type: DataTypes.STRING(9),
        allowNull: false
    },
    data_nasc: {
        type: DataTypes.DATEONLY,
        allowNull: false
    }
}, {
    tableName: 'Usuario',
    timestamps: false, // Não cria colunas createdAt e updatedAt
    hooks: {
        beforeCreate: async (user) => {
            if (user.Senha) {
                const salt = await bcrypt.genSalt(10);
                user.Senha = await bcrypt.hash(user.Senha, salt);
            }
        }
    }
});

// Método para comparar senhas
User.prototype.checkPassword = async function(password) {
    return await bcrypt.compare(password, this.Senha);
};

module.exports = User;
