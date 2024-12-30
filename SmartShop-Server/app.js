const express = require('express')
const models = require('./models')
const app = express()

/// JSON Parse
app.use(express.json())

/// 登録
app.post('/register', (req, res) => {
    const { username, password } = req.body

    ///作成
    const newUser = models.User.create({
        username: username, 
        password: password 
    })

    res.status(201).json({ success: true})

}) 

/// サーバー起動
app.listen(8080, () => {
    console.log('サーバー開始')
})