const express = require('express')
const routes = express.Router()
const { body } = require('express-validator');
const authController = require('../controller/authController')

const registerValidator = [
    body('username', 'ユーザー名を空にすることはできません!').not().isEmpty(),
    body('password', 'パスワードを空にすることはできません!').not().isEmpty()
]

routes.post('/register', registerValidator, authController.register)

module.exports = routes