require('dotenv').config();
const { Sequelize } = require('sequelize');

const sequelize = new Sequelize(process.env.DATABASE_URL, {
  dialect: 'mysql',
  logging: console.log, // Para ver os comandos SQL gerados
});

module.exports = sequelize;
