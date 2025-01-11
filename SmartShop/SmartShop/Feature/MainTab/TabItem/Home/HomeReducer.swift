import ComposableArchitecture
import SwiftUI

@Reducer
struct HomeReducer {
    typealias State = HomeState
    typealias Action = HomeAction

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
