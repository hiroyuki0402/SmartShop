import SwiftUI

extension View {
    func requiresAuthentification() -> some View {
        modifier(RequireAuthenticationModifire())
    }
}
