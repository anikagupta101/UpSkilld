import SwiftUI

struct Resources: View {
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Resources")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("NewGreen"))
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Group {
                        SectionHeader(title: "📈 Investing for Teens")

                        ResourceLink(title: "Fidelity - Investing basics for teens", url: "https://www.fidelity.com/learning-center/personal-finance/teach-teens-investing")
                        ResourceLink(title: "TeenVestor - Stocks, Funds, & Crypto", url: "https://www.teenvestor.com/")
                        ResourceLink(title: "U.S. News - How to Invest as a Teen", url: "https://money.usnews.com/investing/articles/investing-for-teens-how-to-invest-money-as-a-teenager")
                        ResourceLink(title: "Investopedia - What Teens Should Know", url: "https://www.investopedia.com/investing-for-teens-7111843")
                        ResourceLink(title: "College Money Tips - Investing Basics", url: "https://collegemoneytips.com/stock-market-investing-for-teens/")
                    }

                    Group {
                        SectionHeader(title: "💵 Financial Literacy")

                        ResourceLink(title: "Khan Academy - Financial Literacy", url: "https://www.khanacademy.org/college-careers-more/financial-literacy")
                        ResourceLink(title: "TeenLife - 10 Financial Literacy Resources", url: "https://www.teenlife.com/blog/10-online-resources-student-financial-literacy/")
                        ResourceLink(title: "Investopedia - Why It Matters", url: "https://www.investopedia.com/terms/f/financial-literacy.asp")
                        ResourceLink(title: "FDIC - Money Smart", url: "https://www.fdic.gov/consumer-resource-center/money-smart")
                        ResourceLink(title: "Credit Karma - Budgeting for Teens", url: "https://www.creditkarma.com/financial-planning/i/budgeting-for-teens")
                    }

                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 60)
                .foregroundColor(.black)
            }
        }
    }
}

struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(Color("NewGreen"))
    }
}

struct ResourceLink: View {
    let title: String
    let url: String

    var body: some View {
        Link(destination: URL(string: url)!) {
            Text(title)
                .font(.body)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.9))
                .foregroundColor(Color("NewGreen"))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
        }
    }
}

#Preview {
    Resources()
}
