import SwiftUI

struct Invest: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundImage")
                    .resizable()
                    .ignoresSafeArea()
                    .allowsHitTesting(false)

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Investing!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                            .frame(maxWidth: .infinity, alignment: .center)

                        Group {
                            Text("💡 Daily Tip")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            
                            Text("Your Money's Secret Superpower: Compound Interest!")
                                .font(.headline)

                            Text("Think of compound interest like a snowball rolling downhill — it gets bigger over time. You earn interest on your savings *and* on the interest you've already earned!")


                            Spacer()
                            
                            Text("Actionable Tip:")
                                .font(.headline)

                            Text("Start early! Even $10 a week from age 15 can grow to over $250,000 by age 65, thanks to the magic of compounding (which 10x your money).")

                        }

                        Divider()

                        Group {

                            NavigationLink(destination: Quiz()) {
                                InvestButton(title: "Take the Quiz")
                            }
                            
                            .padding(.vertical, 20)
                            
                            Text("📚 Learn More")
                                .font(.title2)
                                .fontWeight(.semibold)

                            NavigationLink(destination: Videos()) {
                                InvestButton(title: "Watch Videos")
                            }

                            NavigationLink(destination: Resources()) {
                                InvestButton(title: "Explore Resources")
                            }
                        }

                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 60)
                    .foregroundColor(.black)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct InvestButton: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 18, weight: .semibold))
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("NewGreen").opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    Invest()
}
