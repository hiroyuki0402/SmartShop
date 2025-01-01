import SwiftUI

struct AuthorizationEnvironmentKey: EnvironmentKey {
    static let defaultValue = AuthorizationController(httpClient: HTTPClient())
}

extension EnvironmentValues {

    var authorizationController: AuthorizationController {
        get { self[AuthorizationEnvironmentKey.self] }
        set { self[AuthorizationEnvironmentKey.self] = newValue}
    }
}
