import ComposableArchitecture
import SwiftUI

@Reducer
struct CartReducer {
    typealias State = CartState
    typealias Action = CartAction

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
