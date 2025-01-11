import SwiftUI
import ComposableArchitecture

struct CartView: View {
    var store: StoreOf<CartReducer>
    var body: some View {
        Text("CartView")
    }
}
