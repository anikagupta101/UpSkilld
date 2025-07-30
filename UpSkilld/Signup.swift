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

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Create an Account")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.black)

                        Group {
                            TextField("First Name", text: $firstName)
                            TextField("Last Name", text: $lastName)
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                            DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                                .foregroundColor(.black)
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

                        Button(action: {
                            if validateInputs() {
                                saveUserData()
                                goToLogin = true
                            }
                        }) {
                            Text("Sign Up")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.top, 10)

                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationTitle("Sign Up")
        }
    }

    func validateInputs() -> Bool {
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty ||
            grade.isEmpty || username.isEmpty || password.isEmpty {
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
        UserDefaults.standard.set(firstName, forKey: "firstName")
        UserDefaults.standard.set(lastName, forKey: "lastName")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(birthday, forKey: "birthday")
        UserDefaults.standard.set(grade, forKey: "grade")
        UserDefaults.standard.set(username.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "username")
        UserDefaults.standard.set(password.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "password")

        print("Saved username: \(username), password: \(password)")
    }
}


#Preview {
    Signup()
}
