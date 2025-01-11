import SwiftUI

@main
struct SmartShopApp: App {
    @State private var token: String?
    @State private var isLoading: Bool = true

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if isLoading {
                    // TODO: カスタム作成
                    ProgressView("ローディング中")
                } else {
                    navigateBasedOnSession()
                }
            }
            .onAppear {
                token = KeychainWrapper.get(for: "jwttoken")
                isLoading = false
            }
        }
    }

    private func isSessionExpired() -> Bool {
        JWTTokenValidator.validate(token)
    }

    private func navigateBasedOnSession() -> some View {
        Group {
            if isSessionExpired() {
                MainTabView(store: .init(initialState: MainTabReducer.State(), reducer: {
                    MainTabReducer()
                }))
                .environment(\.authorizationController, .develop)
            } else {
                LoginView(store: .init(initialState: LoginReducer.State(), reducer: {
                    LoginReducer()
                }))
            }
        }
    }
}
