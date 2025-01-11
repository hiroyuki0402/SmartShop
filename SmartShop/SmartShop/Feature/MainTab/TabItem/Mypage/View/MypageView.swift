import SwiftUI
import ComposableArchitecture

struct MypageView: View {
    var store: StoreOf<MypageReducer>

    var body: some View {
        Text("MypageView")
    }
}
