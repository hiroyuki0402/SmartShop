import MyLibrary
import Foundation

struct AuthorizationController {
    let httpClient: HTTPClient

    func register(username: String, password: String) async throws -> RegisterData? {

        let body = ["username": username ,"password": password]
        let data = try JSONEncoder().encode(body)

        let resource: APIResource = .init(url: TestAPI.register, method: .post(data), modelType: RegisterData.self)
        let response = try await APIManager.shared.callAPIUsingAsync(resource)

        return response
    }
}

extension AuthorizationController {
    static var develop: AuthorizationController {
        AuthorizationController(httpClient: HTTPClient())
    }
}
