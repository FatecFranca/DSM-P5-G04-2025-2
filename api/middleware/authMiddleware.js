const jwt = require('jsonwebtoken');

const authMiddleware = (req, res, next) => {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({ error: 'Token de autenticação não fornecido ou mal formatado' });
    }

    const token = authHeader.split(' ')[1];

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded; // Adiciona os dados do usuário (ex: id) ao objeto da requisição
        next(); // Passa para a próxima função (o controller)
    } catch (error) {
        return res.status(401).json({ error: 'Token inválido ou expirado' });
    }
};

module.exports = authMiddleware;
