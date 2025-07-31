import SwiftUI

struct Login: View {
    @State private var enteredUsername = ""
    @State private var enteredPassword = ""
    @State private var loginErrorMessage = ""
    @State private var goToHome = false
    @State private var showPassword = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundImage")
                    .resizable()
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                
                    .onTapGesture {
                        hideKeyboard()
                    }
                
                VStack(spacing: 20) {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()

                    TextField("Username", text: $enteredUsername)
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    HStack {
                        Group {
                            if showPassword {
                                TextField("Password", text: $enteredPassword)
                            } else {
                                SecureField("Password", text: $enteredPassword)
                            }
                        }
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }

                    if !loginErrorMessage.isEmpty {
                        Text(loginErrorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    HStack {
                        Spacer()
                        Button("Login") {
                            if validateLogin() {
                                goToHome = true
                            }
                            hideKeyboard()
                        }
                        .bold()
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(Color("NewGreen") custom green color
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        Spacer()
                    }

                }
                .padding()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }

    func validateLogin() -> Bool {
        let savedUsername = UserDefaults.standard.string(forKey: "username")?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let savedPassword = UserDefaults.standard.string(forKey: "password")?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let inputUsername = enteredUsername.trimmingCharacters(in: .whitespacesAndNewlines)
        let inputPassword = enteredPassword.trimmingCharacters(in: .whitespacesAndNewlines)

        print("Entered username: \(inputUsername)")
        print("Saved username: \(savedUsername)")
        print("Entered password: \(inputPassword)")
        print("Saved password: \(savedPassword)")

        if inputUsername.isEmpty || inputPassword.isEmpty {
            loginErrorMessage = "Please enter username and password."
            return false
        }

        if inputUsername != savedUsername || inputPassword != savedPassword {
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
