//
//  FinancesSwift.swift
//  UpSkilld
//
//  Created by Scholar on 7/29/25.
//

import Foundation
import SwiftUI

/*struct FinancesView: View {
    var body: some View {
        VStack {
            Text("Finances Swift")
        }
        .navigationTitle("Finances")
        .navigationBarTitleDisplayMode(.inline)
*/

class Finance{
    var totalIncome: Double
    var needs = 0.0
    var wants = 0.0
    var savings = 0.0
    
    init(totalIncome: Double){
        self.totalIncome = totalIncome
    }
    
    func calculations() {
        needs = totalIncome * 0.5
        wants = totalIncome * 0.3
        savings = totalIncome * 0.2
        //print("Needs: \(needs); Wants: \(wants); Savings: \(savings)")
    }
    
    func smartCheck(){
        
    }
    
}

//var text = Finance(totalIncome: 100)




