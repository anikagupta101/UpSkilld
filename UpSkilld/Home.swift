import SwiftUI

struct Home: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.96, green: 0.94, blue: 0.90)
                    .ignoresSafeArea()

                VStack(spacing: 40) {
                    Text("UpSkilld")
                        .font(.system(size: 45, weight: .bold))
                        .foregroundColor(Color(red: 0.22, green: 0.55, blue: 0.32))
                        .shadow(radius: 2)

                    VStack(spacing: 20) {
                        NavigationLink(destination: Finances()) {
                            HomeButton(title: "Finances", background: .white, textColor: .black)
                        }

                        NavigationLink(destination: Invest()) {
                            HomeButton(title: "Invest", background: .white, textColor: .black)
                        }

                        NavigationLink(destination: ShortFormContent()) {
                            HomeButton(title: "Ups", background: .white, textColor: .black)
                        }

                        NavigationLink(destination: StockListView()) {
                            HomeButton(title: "Explore Stocks", background: Color(red: 0.22, green: 0.55, blue: 0.32), textColor: .white)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct HomeButton: View {
    let title: String
    let background: Color
    let textColor: Color

    var body: some View {
        Text(title)
            .font(.system(size: 18, weight: .semibold))
            .frame(width: 250)
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
