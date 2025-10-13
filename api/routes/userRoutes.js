const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const authMiddleware = require('../middleware/authMiddleware');

// Rota para criar um novo usuário (POST /usuarios)
router.post('/', userController.createUser);

// Rota para obter todos os usuários (GET /usuarios)
router.get('/', authMiddleware, userController.getAllUsers);

// Rota para obter um usuário pelo ID (GET /usuarios/:id)
router.get('/:id', authMiddleware, userController.getUserById);

// Rota para atualizar um usuário (PUT /usuarios/:id)
router.put('/:id', authMiddleware, userController.updateUser);

// Rota para deletar um usuário (DELETE /usuarios/:id)
router.delete('/:id', authMiddleware, userController.deleteUser);

module.exports = router;
