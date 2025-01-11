import ComposableArchitecture
import SwiftUI

@Reducer
struct MyProductsReducer {
    typealias State = MyProductsState
    typealias Action = MyProductsAction

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
