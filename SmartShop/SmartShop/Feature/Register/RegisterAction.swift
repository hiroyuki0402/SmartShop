import ComposableArchitecture
import SwiftUI
import MyLibrary

enum RegisterAction: BindableAction {
    case binding(BindingAction<RegisterState>)
    case formValid
    case request(AuthorizationController)
    case registrationSucceeded(RegisterData?)
    case registrationFailed(ErrorReponse?)
}
