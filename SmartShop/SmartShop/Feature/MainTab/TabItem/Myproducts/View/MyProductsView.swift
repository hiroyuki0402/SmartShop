import SwiftUI
import ComposableArchitecture

struct MyProductsView: View {
    var store: StoreOf<MyProductsReducer>
    
    var body: some View {
        Text("MyProductsView")
    }
}
