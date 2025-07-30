import SwiftUI

struct Login: View {
    @State private var enteredUsername = ""
    @State private var enteredPassword = ""
    @State private var loginErrorMessage = ""
    @State private var goToHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundImage")
                    .resizable()
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                VStack(spacing: 20) {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()

                    TextField("Username", text: $enteredUsername)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)

                    SecureField("Password", text: $enteredPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    if !loginErrorMessage.isEmpty {
                        Text(loginErrorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Button("Login") {
                        if validateLogin() {
                            goToHome = true
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)

                    NavigationLink(destination: Home(), isActive: $goToHome) {
                        EmptyView()
                    }
                }
                .padding()
            }
        }
    }

    func validateLogin() -> Bool {
        let savedUsername = UserDefaults.standard.string(forKey: "username") ?? ""
        let savedPassword = UserDefaults.standard.string(forKey: "password") ?? ""

        if enteredUsername.isEmpty || enteredPassword.isEmpty {
            loginErrorMessage = "Please enter username and password."
            return false
        }

        if enteredUsername != savedUsername || enteredPassword != savedPassword {
            loginErrorMessage = "Incorrect username or password."
            return false
        }

        loginErrorMessage = ""
        return true
    }
}

#Preview {
    Login()
}
