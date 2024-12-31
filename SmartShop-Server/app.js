const express = require('express')
const models = require('./models')
const bcryptjs = require('bcryptjs')
const app = express()
const { body, validationResult } = require('express-validator');
const { Model, where, Op } = require('sequelize');

/// JSON Parse
app.use(express.json())

const registerValidator = [
    body('username', 'ユーザー名を空にすることはできません!').not().isEmpty(),
    body('password', 'パスワードを空にすることはできません!').not().isEmpty()]

/// 登録
app.post('/register', registerValidator, async (req, res) => {

    /// リクエストデータに対するバリデーション結果を取得
    const error = validationResult(req)

    /// バリデーションエラーが存在するかチェック
    if (!error.isEmpty()) {

        /// エラーメッセージを配列として取得し、1つの文字列に結合
        const msg = error.array().map(error => error.msg).join('')

        /// HTTPステータスコード422 (Unprocessable Entity)でエラーを返す
        return res.status(422).json({ success: false, message: msg })
    }

    try {
        /// リクエストからusernameとpasswordを取得
        const { username, password } = req.body

        /// 既存のユーザー名が見つかった場合の処理
        /// データベース内で、リクエストで送信された username を持つユーザーが既に存在するかを確認する
        const existingUser = await models.User.findOne({
            where: {
                username: { [Op.iLike]: username }
            }
        })


        /// ユーザー名が既に存在している場合の処理
        if (existingUser) {

            /// 既存のユーザーが見つかった場合、クライアントにエラーメッセージを返す
            return res.json({
                message: 'User Name Taken',
                success: false
            })
        }

        /// パスワードをハッシュ化する
        const salt = await bcryptjs.genSalt(10)
        const hash = await bcryptjs.hash(password, salt)

        ///作成
        const newUser = models.User.create({
            username: username,
            password: hash
        })

        res.status(201).json({ success: true })

    } catch (error) {
        res.status(500).json({
            message: 'サーバーエラー',
            success: false
        })

    }
})

/// サーバー起動
app.listen(8080, () => {
    console.log('サーバー開始')
})