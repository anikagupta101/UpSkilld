//
//  Resources.swift
//  UpSkilld
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct Resources: View {
    var body: some View {
        VStack {
            Text("Welcome to resources!")
                .font(.title)
                .frame(width: 300, height: 75)
            
            Text("Investing for Teens: Websites/Articles")
            Link(destination: URL(string:"https://www.fidelity.com/learning-center/personal-finance/teach-teens-investing")!) {
               Text("Fidelity - Investing basics for teens")
            } //closes Link
            .padding()
            Link(destination: URL(string:"https://www.teenvestor.com/")!) {
               Text("TeenVestor - Investing for Teens: stocks, funds, & cryptos")
            } //closes Link
            .padding()
            Link(destination: URL(string:"https://money.usnews.com/investing/articles/investing-for-teens-how-to-invest-money-as-a-teenager")!) {
               Text("U.S. News - Investing for Teens: How to Invest Money as a Teenager")
            } //closes Link
            .padding()
            Link(destination: URL(string:"https://www.investopedia.com/investing-for-teens-7111843")!) {
               Text("Investopedia - Investing for Teens: What They Should Know")
            } //closes Link
            .padding()
            Link(destination: URL(string:"https://collegemoneytips.com/stock-market-investing-for-teens/")!) {
               Text("College Money Tips - The Basics of Stock Market Investing: What Every Parent Should Know About Investing for Teens")
            } //closes Link
            .padding()
            .frame(width: 300, height: 100)
            
            Text("Financial Literacy for Teens: Websites/Articles")
            Link(destination: URL(string:"https://www.khanacademy.org/college-careers-more/financial-literacy")!) {
               Text("Khan Academy - Financial Literacy")
            } //closes Link
            .padding()
            Link(destination: URL(string:"https://www.teenlife.com/blog/10-online-resources-student-financial-literacy/")!) {
               Text("TeenLife - 10 Online Resources for Student Financial Literacy")
            } //closes Link
            .padding()
            Link(destination: URL(string:"https://www.investopedia.com/terms/f/financial-literacy.asp")!) {
               Text("Investopedia - Financial Literacy: What It Is, and Why It Is So Important to Teach Teens")
            } //closes Link
            .padding()
            Link(destination: URL(string:"https://www.fdic.gov/consumer-resource-center/money-smart")!) {
               Text("FDIC - Money Smart")
            } //closes Link
            .padding()
            Link(destination: URL(string:"https://www.creditkarma.com/financial-planning/i/budgeting-for-teens")!) {
               Text("Credit Karma - Budgeting for teens: 18 tips for growing your money young")
            } //closes Link
            .padding()
        } //closes VStack
    } //closes var body
} //closes struct

#Preview {
    Resources()
}
