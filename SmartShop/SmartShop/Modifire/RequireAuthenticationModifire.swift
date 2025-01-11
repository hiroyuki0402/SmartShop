import SwiftUI
import ComposableArchitecture

struct RequireAuthenticationModifire: ViewModifier {

    @State private var isLoading: Bool = true
    @AppStorage("userID") private var userId: Int?

    func body(content: Content) -> some View {
        Group {
            if isLoading {
                ProgressView("")
            } else {
                if userId != nil {
                    content
                } else {
                    LoginView(store: .init(initialState: LoginReducer.State(), reducer: {
                        LoginReducer()
                    }))
                }
            }
        }
        .onAppear(perform: checkAuthentication)
    }

    private func checkAuthentication() {
        let token: String? = KeychainWrapper.get(for: "jwttoken")
        guard let token, JWTTokenValidator.validate(token) else {
            userId = nil
            isLoading = false
            return
        }

        isLoading = false
    }
}
