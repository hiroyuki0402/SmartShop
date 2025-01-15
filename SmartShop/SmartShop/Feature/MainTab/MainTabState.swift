import ComposableArchitecture
import SwiftUI

@ObservableState
struct MainTabState: Equatable {
    var selectedTab: MainTabItem = .home
    var homeState = HomeState()
    var myproductsState = MyProductsState()
    var mypageState = MypageState()
    var cartState = CartState()
    var loginState = LoginState()
    var isAuthenticated = false
}
