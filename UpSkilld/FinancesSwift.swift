//
//  FinancesSwift.swift
//  UpSkilld
//
//  Created by Scholar on 7/29/25.
//

import Foundation


class Finance{
    var totalIncome: Double
    var needs: Double
    var wants: Double
    var savings: Double
    
    init(totalIncome: Double, needs: Double, wants: Double, savings: Double){
        self.totalIncome = totalIncome
        self.needs = needs
        self.wants = wants
        self.savings = savings
    }
    
    func Calculations() {
        needs = needs * 0.5
        wants = wants * 0.3
        savings = savings * 0.2
        
    }
}



