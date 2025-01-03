import SwiftUI
import ComposableArchitecture

struct RegistrationView: View {
    @Environment(\.authorizationController) var authorizationController
    var store: StoreOf<RegisterReducer>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Form {
                TextField("Email", text: viewStore.$email)
                    .textInputAutocapitalization(.never)
                    .onChange(of: viewStore.email) { oldValue, newValue in
                        viewStore.send(.formValid)
                    }

                SecureField("Password", text: viewStore.$password)
                    .onChange(of: viewStore.password) { oldValue, newValue in
                        viewStore.send(.formValid)
                    }

                Button("登録") {
                    viewStore.send(.request(authorizationController))
                }
                .disabled(!viewStore.isFormValid)
            }
            .navigationTitle("登録画面")
        }
    }
}
#Preview {
    RegistrationView(store: .init(initialState: RegisterReducer.State(), reducer: {
        RegisterReducer()
    }))
    .environment(\.authorizationController, .develop)
}
