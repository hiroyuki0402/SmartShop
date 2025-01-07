import SwiftUI
import ComposableArchitecture

enum LoginAction: BindableAction {
    case binding(BindingAction<LoginState>)
    case formValid
    case request(AuthorizationController)
    case loginSucceeded(LoginData?)
    case loginFailed(ErrorReponse?)
    case saveStorage(Int)
}
