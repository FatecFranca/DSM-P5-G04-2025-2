require('dotenv').config();
const express = require('express');
const sequelize = require('./database/connection');
const userRoutes = require('./routes/userRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware para interpretar JSON
app.use(express.json());

// Rota principal
app.get('/', (req, res) => {
    res.send('API CafeZen está no ar!');
});

// Usar as rotas de usuário para o endpoint /usuarios
app.use('/usuarios', userRoutes);

// Testar conexão com o banco e iniciar o servidor
const startServer = async () => {
    try {
        await sequelize.authenticate();
        console.log('Conexão com o banco de dados estabelecida com sucesso.');

        // Sincronizar modelos com o banco de dados
        // force: false para não apagar os dados existentes
        await sequelize.sync({ force: false });
        console.log('Modelos sincronizados com o banco de dados.');

        app.listen(PORT, '0.0.0.0', () => {
            console.log(`Servidor rodando na porta ${PORT}.`);
            console.log(`Acesse em http://localhost:${PORT} ou http://20.150.192.36:${PORT}`);
        });
    } catch (error) {
        console.error('Não foi possível conectar ao banco de dados:', error);
    }
};

startServer();
