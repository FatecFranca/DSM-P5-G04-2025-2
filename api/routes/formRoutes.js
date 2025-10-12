const express = require('express');
const router = express.Router();
const formController = require('../controllers/formController');
const authMiddleware = require('../middleware/authMiddleware');

// Rota para criar um novo formulário (POST /forms)
// A rota é protegida pelo authMiddleware
router.post('/', authMiddleware, formController.createForm);

module.exports = router;
