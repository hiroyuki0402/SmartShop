import ComposableArchitecture

struct RegisterState: Equatable {
    @BindingState var email: String = ""
    @BindingState var password: String = ""
    @BindingState var isFormValid: Bool = false
}
