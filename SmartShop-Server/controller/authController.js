const bcryptjs = require('bcryptjs')
const models = require('../models')
const jwt = require('jsonwebtoken')
const { validationResult } = require('express-validator');
const { Op, where } = require('sequelize');

/// ユーザーのログイン処理を担当する非同期関数
exports.login = async (req, res) => {

    try {
        /// リクエストデータに対するバリデーション結果を取得
        const error = validationResult(req);

        /// バリデーションエラーが存在するかチェック
        if (!error.isEmpty()) {

            /// エラーメッセージを配列として取得し、1つの文字列に結合
            const msg = error.array().map(error => error.msg).join('')

            /// HTTPステータスコード422 (Unprocessable Entity)でエラーを返す
            return res.status(422).json({ success: false, message: msg })
        }
        
        /// リクエストボディからユーザー名とパスワードを取得
        const { username, password } = req.body

        /// データベースから、入力されたユーザー名に一致するユーザー情報を検索
        const existingUser = await models.User.findOne({
            where: {
                username: { [Op.iLike]: username }
            }
        })

        /// ユーザーが存在しない場合、エラーレスポンスを返す
        if (!existingUser) {
            return res.status(401).json({ message: "パスワードまたはIDが正しくありません", success: false })
        }

        /// 入力されたパスワードとデータベースに保存されたハッシュ化パスワードを比較して認証を行う
        const isPasswordValid = await bcryptjs.compare(password, existingUser.password)
        if (!isPasswordValid) {
            /// パスワードが一致しない場合、認証エラーを返す
            return res.status(401).json({ message: "パスワードまたはIDが正しくありません", success: false })
        }

        /// ユーザーIDをペイロードに含めたJWTトークンを生成する
        const taken = jwt.sign({ username: existingUser.id }, 'SECRETKEY', {
            expiresIn: '1h'
        })

        /// 認証成功時に、ユーザー情報と生成したトークンをレスポンスとして返す
        return res.status(200).json({ userId: existingUser.id, username: existingUser.username, taken, success: true })
    } catch {
        /// サーバー内部エラーが発生した場合、エラーレスポンスを返す
        return res.status(500).json({ message: "サーバ内部エラーが発生しました", success: false })
    }
}

/// 会員登録
exports.register = async (req, res) => {
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
}