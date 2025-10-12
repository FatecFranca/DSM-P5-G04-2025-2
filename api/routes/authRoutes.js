const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// Rota para login (POST /login)
router.post('/', userController.loginUser);

module.exports = router;
