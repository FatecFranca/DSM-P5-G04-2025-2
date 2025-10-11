const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// Rota para criar um novo usuário (POST /usuarios)
router.post('/', userController.createUser);

// Rota para obter todos os usuários (GET /usuarios)
router.get('/', userController.getAllUsers);

module.exports = router;
