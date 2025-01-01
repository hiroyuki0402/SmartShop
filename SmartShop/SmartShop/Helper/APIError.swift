import MyLibrary
import Foundation

extension NetworkError: @retroactive LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badRequest:
            return NSLocalizedString("不正なリクエスト (400): リクエストを実行できませんでした。", comment: "badRequestError")

        case .decodingError(let error):
            return NSLocalizedString("正常にデコードできませんでした。\(error)", comment: "decodingError")

        case .invalidResponse:
            return NSLocalizedString("無効なレスポンスです。", comment: "invalidResponse")

        case .errorResponse(let errorResponse):
            return NSLocalizedString("エラー \(errorResponse)", comment: "Error Response")

        case .badURL:
            return NSLocalizedString("URLが不正です", comment: "Error URL")

        case .codeValidatoeError(_):
            return NSLocalizedString("ステータスコードがエラーです", comment: "Error StatusCode")
        }
    }

}

enum ExtendedNetworkError {
    case base(NetworkError)
    case customErrorResponse(ErrorReponse)
}
