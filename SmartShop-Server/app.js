const express = require('express')
const cors = require('cors')

const app = express()

const authRoutes = require('./routes/auth')

/// Cors
app.use(cors())

/// JSON Parse
app.use(express.json())

app.use('/api/auth', authRoutes)

/// サーバー起動
app.listen(8080, () => {
    console.log('サーバー開始')
})