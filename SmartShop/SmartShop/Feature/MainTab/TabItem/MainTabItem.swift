import SwiftUI
import ComposableArchitecture

enum MainTabItem: Hashable, Identifiable, CaseIterable {
    case home
    case myproduct
    case cart
    case mypage

    var id: MainTabItem { self }

    /// タイトル
    var title: String {
        switch self {
        case .home: return "Home"
        case .myproduct: return "MyProducts"
        case .cart: return "Store"
        case .mypage: return "My Page"
        }
    }

    /// アイコン
    var icon: String {
        switch self {
        case .home: return "house"
        case .myproduct: return "star"
        case .cart: return "cart"
        case .mypage: return "person"
        }
    }

    /// 各タブのビューを返す
    @ViewBuilder
    func view(store: StoreOf<MainTabReducer>) -> some View {
        switch self {
        case .home:
            HomeView(store: store.scope(state: \.homeState, action: \.homeAction))

        case .myproduct:
            MyProductsView(store: store.scope(state: \.myproductsState, action: \.myproductsAction))
                .requiresAuthentification(
                    store: store.scope(state: \.loginState, action: \.loginAction)
                )

        case .cart:
            CartView(store: store.scope(state: \.cartState, action: \.cartAction))

        case .mypage:
            MypageView(store: store.scope(state: \.mypageState, action: \.mypageAction))
        }
    }
}
