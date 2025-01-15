import SwiftUI

@main
struct SmartShopApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView(store: .init(initialState: MainTabReducer.State(), reducer: {
                MainTabReducer()
            }))
            .environment(\.authorizationController, .develop)
        }
    }
}
