
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()

                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .offset(x: 0, y: -10)

                VStack(spacing: 5) {
                    Text("Welcome to")
                        .font(.system(size: 32))
                        .offset(x: 0, y: -50)
                    
                    Text("UpSkilld")
                        .font(.system(size: 42))
                        .bold()
                        .bold()
                        .offset(x: 0, y: -50)
                }

                VStack(spacing: 20) {
                    NavigationLink(destination: Login()) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .font(.system(size: 25))
                            .bold()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .frame(width: 200)
                            .offset(x: 0, y: -40)
                    }

                    NavigationLink(destination: Signup()) {
                        Text("Signup")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .font(.system(size: 25))
                            .bold()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .frame(width: 200)
                            .offset(x: 0, y: -30)
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
