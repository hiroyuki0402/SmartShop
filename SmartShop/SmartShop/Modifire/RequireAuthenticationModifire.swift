import SwiftUI
import ComposableArchitecture

struct RequireAuthenticationModifire: ViewModifier {

    @State private var isLoading: Bool = true
    @AppStorage("userID") private var userId: Int?
    let store: StoreOf<LoginReducer>

    func body(content: Content) -> some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Group {
                if isLoading {
                    ProgressView("")
                } else {
                    if viewStore.userID != nil {
                        content
                    } else {
                        LoginView(store: store)
                    }
                }
            }
            .onAppear(perform: checkAuthentication)
            .onChange(of: userId) { oldValue, newValue in
                isLoading = false
            }
        }
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
