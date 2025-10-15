const express = require('express');
const router = express.Router();
const formController = require('../controllers/formController');
const authMiddleware = require('../middleware/authMiddleware');

// Rota para criar um novo formulário (POST /forms)
// A rota é protegida pelo authMiddleware
router.post('/', authMiddleware, formController.createForm);

// Rota para buscar o formulário do usuário logado (GET /forms)
router.get('/', authMiddleware, formController.getForm);

// Rota para atualizar o formulário do usuário logado (PUT /forms)
router.put('/', authMiddleware, formController.updateForm);

module.exports = router;
