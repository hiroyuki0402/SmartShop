import Foundation

struct LoginData: Codable {
    var message: String?
    var success: Bool
    var token: String?
    var userId: Int?
    var username: String?
}
