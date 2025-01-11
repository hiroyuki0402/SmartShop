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

        Reduce { state, action in
            switch action {
            case let .selectedTab(tab):
                state.selectedTab = tab
                return .none

            default:
                return .none
            }
        }
    }
}
