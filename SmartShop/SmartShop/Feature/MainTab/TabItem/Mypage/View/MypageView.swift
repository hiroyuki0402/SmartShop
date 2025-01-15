import SwiftUI
import ComposableArchitecture

struct MypageView: View {
    var store: StoreOf<MypageReducer>

    var body: some View {
        Button("ログアウト") {
            let _ = KeychainWrapper<String>.delete(key: "jwttoken")
        }
    }
}
