import SwiftUI

struct Home: View {
    @State private var firstName: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.96, green: 0.94, blue: 0.90)
                    .ignoresSafeArea()

                VStack(spacing: 24) {

                    HStack {
                        Text("Hi, \(firstName)! 👋")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                            .offset(x: 20, y:30)
                        Spacer()
                    }


                    Text("UpSkilld")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(Color("NewGreen"))
                        .multilineTextAlignment(.center)
                        .offset(y: 70)

                    Spacer()

  
                    VStack(spacing: 25) {
                        NavigationLink(destination: Finances()) {
                            HomeButton(title: "Finances", background: Color("NewGreen").opacity(0.5), textColor: .white)
                                .frame(width: 190)
                                .offset(y:-30)
                        }

                        NavigationLink(destination: Invest()) {
                            HomeButton(title: "Invest", background: Color("NewGreen").opacity(0.5), textColor: .white)
                                .frame(width: 190)
                                .offset(y:-30)
                        }

                        NavigationLink(destination: ShortFormContent()) {
                            HomeButton(title: "Ups", background: Color("NewGreen").opacity(0.5), textColor: .white)
                                .frame(width: 190)
                                .offset(y:-30)
                        }

                        NavigationLink(destination: StockListView()) {
                            HomeButton(title: "Explore Stocks", background: Color("NewGreen").opacity(0.5), textColor: .white)
                                .frame(width: 190)
                                .offset(y:-30)
                        }
                    }
                    .padding(.top, 40)

                    Spacer(minLength: 40)
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            firstName = UserDefaults.standard.string(forKey: "firstName") ?? "Investor"
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
