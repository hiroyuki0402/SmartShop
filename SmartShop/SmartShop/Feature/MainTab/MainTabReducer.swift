import ComposableArchitecture
import SwiftUI

@Reducer
struct MainTabReducer {
    typealias State = MainTabState

    enum Action: BindableAction {
        case binding(BindingAction<MainTabState>)
        case selectedTab(MainTabItem)
        case homeAction(HomeAction)
        case myproductsAction(MyProductsAction)
        case mypageAction(MypageAction)
        case cartAction(CartAction)
        case loginAction(LoginAction)
    }

    var body: some ReducerOf<Self> {
        BindingReducer()

        Scope(state: \.homeState, action: \.homeAction) {
            HomeReducer()
        }

        Scope(state: \.myproductsState, action: \.myproductsAction) {
            MyProductsReducer()
        }

        Scope(state: \.mypageState, action: \.mypageAction) {
            MypageReducer()
        }

        Scope(state: \.cartState, action: \.cartAction) {
            CartReducer()
        }

        Scope(state: \.loginState, action: \.loginAction) {
            LoginReducer()
        }

        Reduce { state, action in
            switch action {

            case let .selectedTab(tab):
                state.selectedTab = tab
                return .none

            case .loginAction(let delegate):

                if case let .delegate(delegateAction) = delegate {

                    switch delegateAction {

                    case .loginSucceeded:
                        state.isAuthenticated = true

                        return .none
                    }
                } else {
                    return .none
                }


            default:
                return .none
            }
        }
    }
}
