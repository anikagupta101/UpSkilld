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
                            SecureField("Create Password", text: $password)
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                        NavigationLink(destination: Login(), isActive: $goToLogin) {
                            EmptyView()
                        }

                        Button(action: {
                            goToLogin = true
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
}

#Preview {
    Signup()
}
