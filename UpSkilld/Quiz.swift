//
//  Quiz.swift
//  UpSkilld
//
//  Created by Scholar on 7/30/25.
//

import SwiftUI

struct QuizQuestion {
    let questionText: String
    let options: [String]
    let correctAnswerIndex: Int
    let rationale: String
}

struct Quiz: View {
    let questions: [QuizQuestion] = [
        QuizQuestion(
            questionText: "What is the primary purpose of a budget?",
            options: [
                "To track your friends' spending habits.",
                "To see how much debt you can accumulate.",
                "To plan how you will spend and save your money.",
                "To avoid paying taxes."
            ],
            correctAnswerIndex: 2,
            rationale: "A budget helps you plan how to manage your income and expenses to achieve your financial goals."
        ),
        QuizQuestion(
            questionText: "True or False: Paying only the minimum balance on your credit card each month is the best way to avoid debt.",
            options: [
                "True",
                "False"
            ],
            correctAnswerIndex: 1,
            rationale: "False. Paying only the minimum balance on a credit card usually means you'll pay a lot more in interest over time and stay in debt longer."
        ),
        QuizQuestion(
            questionText: "Diversification in investing is best described as:",
            options: [
                "Putting all your money into a single, high-growth stock.",
                "Spreading your investments across different types of assets to reduce risk.",
                "Only investing in companies you are familiar with.",
                "Constantly buying and selling stocks to maximize profit."
            ],
            correctAnswerIndex: 1,
            rationale: "Diversification means spreading your investments across various assets (like different stocks, bonds, or real estate) to reduce the overall risk in your portfolio."
        ),
        QuizQuestion(
            questionText: "What is the difference between a Roth IRA and a Traditional IRA?",
            options: [
                "Roth IRAs are only for retirement, while Traditional IRAs are for any goal.",
                "Contributions to a Roth IRA are tax-deductible, while Traditional IRA withdrawals in retirement are tax-free.",
                "Contributions to a Traditional IRA may be tax-deductible, while Roth IRA withdrawals in retirement are tax-free.",
                "There is no difference, just different names."
            ],
            correctAnswerIndex: 2,
            rationale: "Contributions to a Traditional IRA may be tax-deductible (you get a tax break now), but withdrawals in retirement are taxed. For a Roth IRA, you contribute after-tax money, but qualified withdrawals in retirement are tax-free."
        ),
        QuizQuestion(
            questionText: "What does 'compounding' refer to in the context of investing?",
            options: [
                "The process of losing money quickly on an investment.",
                "Earning returns on your initial investment and on the accumulated interest or returns from previous periods.",
                "The total amount of money you invest in a single year.",
                "The fees charged by a financial advisor."
            ],
            correctAnswerIndex: 1,
            rationale: "Compounding is when your investment earns returns, and then those returns also start earning returns. It's often called 'interest on interest' and is a powerful way for money to grow over time."
        )
    ]
    
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var selectedAnswerIndex: Int? = nil //stores the user's selected option
    @State private var showRationale = false //controls showing the explanation
    @State private var feedbackMessage: String = "" //USED TO CONVEY CORRECT/INCORRECT RESPONSE TO USER
    @State private var quizCompleted = false
    
    
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
            //.scaledToFill()
                .ignoresSafeArea()
                .allowsHitTesting(false)
            
            VStack {
                Spacer()
                
                if quizCompleted {
                    VStack(spacing: 20) {
                        Text("Quiz Completed!")
                            .font(.title)
                        Text("You scored \(score) out of \(questions.count)")
                        Button("Restart Quiz") {
                            currentQuestionIndex = 0
                            score = 0
                            selectedAnswerIndex = nil
                            showRationale = false
                            feedbackMessage = ""
                            quizCompleted = false
                        }
                        .padding()
                    } //closes VStack
                } //closes if loop
                else {
                    Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text(questions[currentQuestionIndex].questionText)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    
                    ForEach(0..<questions[currentQuestionIndex].options.count, id: \.self) { index in
                        Button(action: {
                            if selectedAnswerIndex == nil { // Only allow selection if not already picked
                                selectedAnswerIndex = index
                                showRationale = true
                                if index == questions[currentQuestionIndex].correctAnswerIndex {
                                    score += 1
                                    feedbackMessage = "Correct!"
                                } else {
                                    feedbackMessage = "Incorrect!"
                                }
                            }
                        }) {
                            Text(questions[currentQuestionIndex].options[index])
                                .padding()
                                .frame(maxWidth: .infinity) // Make buttons take full width
                                .border(Color.gray, width: 1) // Simple border for button visual
                            
                            //USED TO CONVEY CORRECT/INCORRECT RESPONSE TO USER:
                                .background(selectedAnswerIndex == nil ? Color.clear : // No color if no selection yet
                                            (index == questions[currentQuestionIndex].correctAnswerIndex ? Color.green.opacity(0.3) : // Green for correct
                                             (index == selectedAnswerIndex ? Color.red.opacity(0.3) : Color.clear))) // Red for incorrect selected, clear for other options
                        }
                        .padding(.horizontal)
                        .disabled(selectedAnswerIndex != nil) // Disable buttons once an answer is chosen
                    } //closes ForEach loop
                    //USED TO CONVEY CORRECT/INCORRECT RESPONSE TO USER:
                    if !feedbackMessage.isEmpty {
                        Text(feedbackMessage)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(feedbackMessage == "Correct!" ? .green : .red)
                            .padding(.top, 10)
                            .id("feedbackMessage_\(currentQuestionIndex)")
                    } //xloawa id loop
                    if showRationale {
                        Text(questions[currentQuestionIndex].rationale)
                            .font(.caption)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                        
                        if currentQuestionIndex < (questions.count - 1) {
                            Button("Next Question") {
                                selectedAnswerIndex = nil // Reset selection
                                showRationale = false // Hide rationale
                                feedbackMessage = ""
                                currentQuestionIndex += 1 //move to next question
                            } //closes button
                            .padding()
                        } //closes if loop
                        else {
                            //last question, so button should say "View Results"
                            Button("View Results") {
                                quizCompleted = true //quiz finished
                                selectedAnswerIndex = nil //Reset for restart
                                showRationale = false
                            } //closes button
                            .padding()
                        } // closes else loop
                    } //closes if showRational loop
                    Spacer() // Pushes content towards center/bottom
                } //closes else loop
            } //closes VStack
        } //closes ZStack
    } //closes var body
} //closes struct
    
#Preview {
    Quiz()
}
