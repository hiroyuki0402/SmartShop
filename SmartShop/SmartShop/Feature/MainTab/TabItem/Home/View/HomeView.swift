import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    var store: StoreOf<HomeReducer>

    var body: some View {
        Text("homeView")
    }
}
