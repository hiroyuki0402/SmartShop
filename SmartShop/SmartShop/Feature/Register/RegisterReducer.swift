import ComposableArchitecture
import SwiftUI

@Reducer
struct RegisterReducer {
    typealias Action = RegisterAction
    typealias State = RegisterState

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .formValid:
                state.isFormValid = !state.email.isEmpty && !state.password.isEmpty

            case .request(let controller):
                let username = state.email
                let password =  state.password

                return .run { send in

                    do {
                        let result = try await controller.register(
                            username: username,
                            password: password
                        )

                        if let result {
                            await send(.registrationSucceeded(result))
                        } else {
                            let errorReponse = ErrorReponse(message: result?.message)
                            await send(.registrationFailed(errorReponse))
                        }

                    } catch {
                        let errorReponse = ErrorReponse(message: error.localizedDescription)
                        await send(.registrationFailed(errorReponse))
                    }
                }
            default:
                break
            }
            return .none
        }
    }
}
