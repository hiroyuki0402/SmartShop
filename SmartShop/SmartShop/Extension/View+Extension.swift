import SwiftUI
import ComposableArchitecture

extension View {
    func requiresAuthentification(store: StoreOf<LoginReducer>) -> some View {
        self.modifier(RequireAuthenticationModifire(store: store))
    }
}
