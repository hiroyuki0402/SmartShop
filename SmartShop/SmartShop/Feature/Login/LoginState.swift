import ComposableArchitecture
import SwiftUI

@ObservableState
struct LoginState: Equatable {
    var email: String = ""
    var password: String = ""
    var isFormValid: Bool = false
    var message: String = ""
    var userID: Int?
}
