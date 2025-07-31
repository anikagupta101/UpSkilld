import SwiftUI

struct Signup: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var birthday = Date()
    @State private var grade = ""
    @State private var username = ""
    @State private var password = ""
    @State private var goToLogin = false
    @State private var errorMessage = ""
    @State private var showPassword = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundImage")
                    .resizable()
                    .ignoresSafeArea()
                    .onTapGesture {
                        hideKeyboard()
                    }

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Create an Account")
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)

                        Group {
                            TextField("First Name", text: $firstName)
                            TextField("Last Name", text: $lastName)
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                            DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                            TextField("Grade", text: $grade)
                            TextField("Create Username", text: $username)
                                .autocapitalization(.none)
                                .autocorrectionDisabled(true)

                            HStack {
                                Group {
                                    if showPassword {
                                        TextField("Create Password", text: $password)
                                    } else {
                                        SecureField("Create Password", text: $password)
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
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                        }

                        NavigationLink(destination: Login(), isActive: $goToLogin) {
                            EmptyView()
                        }

                        HStack {
                            Spacer()
                            Button("Sign Up") {
                                if validateInputs() {
                                    saveUserData()
                                    goToLogin = true
                                }
                            }
                            .bold()
                            .padding(.horizontal, 40)
                            .padding(.vertical, 12)
                            .background(Color("NewGreen"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            Spacer()
                        }
                    }
                    .padding()
                }
            }
        }
    }

    func validateInputs() -> Bool {
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty || grade.isEmpty || username.isEmpty || password.isEmpty {
            errorMessage = "Please fill in all fields."
            return false
        }

        let calendar = Calendar.current
        let now = Date()
        guard let age = calendar.dateComponents([.year], from: birthday, to: now).year else {
            errorMessage = "Invalid birthday."
            return false
        }

        if age < 13 || age > 18 {
            errorMessage = "You must be between 13 and 18 years old."
            return false
        }

        if password.rangeOfCharacter(from: .uppercaseLetters) == nil {
            errorMessage = "Password must contain at least one uppercase letter."
            return false
        }

        if password.rangeOfCharacter(from: .decimalDigits) == nil {
            errorMessage = "Password must contain at least one number."
            return false
        }

        errorMessage = ""
        return true
    }

    func saveUserData() {
        let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedFirstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)

        UserDefaults.standard.set(trimmedUsername, forKey: "username")
        UserDefaults.standard.set(trimmedPassword, forKey: "password")
        UserDefaults.standard.set(trimmedFirstName, forKey: "firstName") // ✅ Add this

        print("Saved username: \(trimmedUsername)")
        print("Saved password: \(trimmedPassword)")
        print("Saved first name: \(trimmedFirstName)")
    }
}

#Preview {
    Signup()
}
