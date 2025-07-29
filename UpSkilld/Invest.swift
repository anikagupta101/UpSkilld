//
//  Invest.swift
//  UpSkilld
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct Invest: View {
    var body: some View {
        NavigationStack {ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea()
                .allowsHitTesting(false)
            VStack {
                //code for daily tip, beginner tips navigation, tutorials navigation, and resources navigation
                
                Text("Investing!")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(width: 300, height: 50)
                Text("Daily Tip:")
                    .font(.title)
                    .padding()
                Text("Your Money's Secret Superpower: Compound Interest!")
                    .padding()
                Text("Imagine a tiny snowball rolling down a hill. The longer it rolls, the bigger it gets! That's compound interest for your money. You earn interest not just on the new money you deposit, but also on the interest you’ve already earned. It’s how small, regular investments can grow significantly over the years. The earlier you start, the more time your money has to grow!")
                    .padding()
                Text("Actionable Tip: As a teen, time is your biggest advantage! Start with even $10 a week. If you consistently invest just $10 a week ($520 a year) from age 15 until age 65, with a conservative average 7% annual return, you could have over $250,000! You’d only have saved $26,000 of your own money over those 50 years, which shows the incredible power of compounding!")
                    .padding()
                
                NavigationLink(destination: Tips()) {
                    Text("Beginner tips button")
                        .font(.title)
                        .fontWeight(.semibold)
                } //closes NavigationLink
                
                NavigationLink(destination: Tutorials()) {
                    Text("Tutorials button")
                        .font(.title)
                        .fontWeight(.semibold)
                } //closes NavigationLink
                
                NavigationLink(destination: Resources()) {
                    Text("Resources button")
                        .font(.title)
                        .fontWeight(.semibold)
                } //closes NavigationLink
            } //closes VStack
        } //closes NavigationStack
        } //closes var body
    } //closes struct
} //closes z stack

#Preview {
    Invest()
}
