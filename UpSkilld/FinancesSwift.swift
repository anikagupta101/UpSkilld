//
//  FinancesSwift.swift
//  UpSkilld
//
//  Created by Scholar on 7/29/25.
//

import Foundation


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
}

//var text = Finance(totalIncome: 100)




