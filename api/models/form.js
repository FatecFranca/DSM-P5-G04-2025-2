const { DataTypes } = require('sequelize');
const sequelize = require('../database/connection');
const User = require('./user');

const Form = sequelize.define('Form', {
    Id_form: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    Id_usuario: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: User,
            key: 'Id_usuario'
        }
    },
    Idade: DataTypes.INTEGER,
    Genero: DataTypes.STRING(50),
    Pais: DataTypes.STRING(50),
    xicarasDiaCafe: DataTypes.INTEGER,
    horasSono: DataTypes.FLOAT,
    qualidadeDeSono: DataTypes.STRING(50),
    IMC: DataTypes.FLOAT,
    frequenciaCardio: DataTypes.INTEGER,
    problemasDeSaude: DataTypes.STRING(100),
    atvFisicaSemanalHrs: DataTypes.INTEGER,
    Ocupacao: DataTypes.STRING(100),
    Fuma: DataTypes.BOOLEAN,
    Alcool: DataTypes.BOOLEAN
}, {
    tableName: 'Form',
    timestamps: false
});

// Definindo a associação
User.hasMany(Form, { foreignKey: 'Id_usuario' });
Form.belongsTo(User, { foreignKey: 'Id_usuario' });

module.exports = Form;
