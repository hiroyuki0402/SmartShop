import ComposableArchitecture
import SwiftUI

struct MainTabView: View {
    @State var store: StoreOf<MainTabReducer>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            TabView(
                selection: viewStore.binding(
                    get: \.selectedTab,
                    send: MainTabReducer.Action.selectedTab
                )
            ) {
                ForEach(MainTabItem.allCases, id: \.self) { tab in
                    tab.view(store: store)
                        .tabItem {
                            Label(tab.title, systemImage: tab.icon)
                        }
                        .tag(tab)
                }
            }
            .accentColor(.orange)
        }
    }
}

#Preview {
    MainTabView(store: .init(initialState: MainTabReducer.State(), reducer: {
        MainTabReducer()
    }))
    .environment(\.authorizationController, .develop)
}
