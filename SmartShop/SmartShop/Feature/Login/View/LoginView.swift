import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    @Environment(\.authorizationController) var authorizationController
    @State var store: StoreOf<LoginReducer>

    var body: some View {
            Form {
                TextField("Email", text: $store.email)
                    .textInputAutocapitalization(.never)
                    .onChange(of: store.email) { oldValue, newValue in
                        store.send(.formValid)
                    }

                SecureField("Password", text: $store.password)
                    .onChange(of: store.password) { oldValue, newValue in
                        store.send(.formValid)
                    }

                Button("ログイン") {
                    store.send(.request(authorizationController))
                }
                .disabled(!store.isFormValid)
            }
            .navigationTitle("登録画面")
        }
}

#Preview {
    LoginView(store: .init(initialState: LoginReducer.State(), reducer: {
        LoginReducer()
    }))
    .environment(\.authorizationController, .develop)
}
