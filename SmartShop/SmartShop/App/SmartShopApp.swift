import SwiftUI

@main
struct SmartShopApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(store: .init(initialState: LoginReducer.State(), reducer: {
                LoginReducer()
            }))
        }
    }
}
