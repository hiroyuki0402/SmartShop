import Foundation

struct Configuration {
    var baseURL: URL {
        guard let baseURLString = ProcessInfo.processInfo.environment["BASE_URL"],
              let url = URL(string: baseURLString) else {
            fatalError("")
        }
        return url
    }

    var apiKey: String {
        guard let userAPIKey = ProcessInfo.processInfo.environment["USERAPIKEY"] else {
            fatalError("")
        }
        return userAPIKey
    }
}

struct TestAPI {
    static let register: URL = URL(string: "https://localhost:8080/api/auth/register")!
}