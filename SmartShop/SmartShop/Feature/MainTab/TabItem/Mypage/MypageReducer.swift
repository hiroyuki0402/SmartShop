import ComposableArchitecture
import SwiftUI

@Reducer
struct MypageReducer {
    typealias State = MypageState
    typealias Action = MypageAction

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
