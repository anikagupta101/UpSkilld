import SwiftUI

struct Home: View {
    @State private var firstName: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.96, green: 0.94, blue: 0.90)
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 24) {
                    Text("Home")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.black)

                    if !firstName.isEmpty {
                        Text("Hi, \(firstName)! 👋")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.black)
                            .offset(y:20)
                    }

                    VStack(spacing: 10) {
                        NavigationLink(destination: Finances()) {
                            HomeButton(title: "Finances", background: .white, textColor: .black)
                                .offset(y:120)
                                .frame(width: 190)
                        }

                        NavigationLink(destination: Invest()) {
                            HomeButton(title: "Invest", background: .white, textColor: .black)
                                .offset(y:140)
                                .frame(width: 190)
                        }

                        NavigationLink(destination: ShortFormContent()) {
                            HomeButton(title: "Ups", background: .white, textColor: .black)
                                .offset(y:170)
                                .frame(width: 190)
                        }

                        NavigationLink(destination: StockListView()) {
                            HomeButton(title: "Explore Stocks", background: Color(red: 0.22, green: 0.55, blue: 0.32), textColor: .white)
                                .offset(y:200)
                                .frame(width: 230)
                        }
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true) // Hides top bar so you can use your custom "Home" title
        }
        .onAppear {
            firstName = UserDefaults.standard.string(forKey: "firstName") ?? ""
        }
    }
}

struct HomeButton: View {
    let title: String
    let background: Color
    let textColor: Color

    var body: some View {
        Text(title)
            .font(.system(size: 20, weight: .semibold))
            .frame(maxWidth: .infinity)
            .padding()
            .background(background)
            .foregroundColor(textColor)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    Home()
}
  
