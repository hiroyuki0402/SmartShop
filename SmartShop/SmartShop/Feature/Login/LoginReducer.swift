import ComposableArchitecture
import SwiftUI

@Reducer
struct LoginReducer {
    typealias State = LoginState
    typealias Action = LoginAction

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .formValid:
                state.isFormValid = !state.email.isEmpty && !state.password.isEmpty

            case .loginFailed(let error):
                if let error, let message = error.message {
                    state.message = message
                }
            case .saveStorage(let userId):
                @AppStorage("userID") var userId: Int = userId
//                state.userId = userId

            case .request(let controller):
                let username = state.email
                let password =  state.password

                return .run { send in

                    do {
                        let result = try await controller.login(
                            username: username,
                            password: password
                        )

                        guard let result = result, let token = result.token, let userId = result.userId, result.success else {
                            let errorReponse = ErrorReponse(message: result?.message)
                            await send(.loginFailed(errorReponse))
                            return
                        }
                        print(token)
                      //  KeychainWrapper.set(token, for: "jwttoken")

                        if let userId = result.userId {
                            await send(.saveStorage(userId))
                        }


                    } catch {
                        let errorReponse = ErrorReponse(message: error.localizedDescription)
                        await send(.loginFailed(errorReponse))
                    }
                }
            default:
                break
            }
            return .none
        }
    }
}
