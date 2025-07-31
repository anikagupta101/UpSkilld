//
//  FinancesSwift.swift
//  UpSkilld
//
//  Created by Scholar on 7/29/25.
//

import Foundation
import SwiftUI

class Finance{
    var totalIncome: Double
    var needs = 0.0
    var wants = 0.0
    var savings = 0.0
    var smartCheck = 0.0
    var bool = false
    var str = ""
    
    init(totalIncome: Double){
        self.totalIncome = totalIncome
    }
    
    func calculations() {
        needs = totalIncome * 0.5
        wants = totalIncome * 0.3
        savings = totalIncome * 0.2
        //print("Needs: \(needs); Wants: \(wants); Savings: \(savings)")
    }
    
    func smartCheck (sc: Double, bool: Bool){
        //totalIncome = totalIncome
        smartCheck = sc
        self.bool = bool
        
        
        if(smartCheck > wants){
            str = "You're wants budget isn't that high"
        } else{
            if smartCheck >= 0 && smartCheck <= (0.3*wants) {
                //print("here")
                str = "This won't make a dent in your wants budget! Go ahead and enjoy it!"
            } else if smartCheck >= (0.31 * wants) && smartCheck <= (0.6*wants){
                        str = "This takes up a good chunk. Is it worth it or do you want to save it for future use?"
            } else if smartCheck >= (0.61 * wants) && smartCheck <= (0.85 * wants){
                str = "This is more you your fun money. Treat yourself, or wait for something bigger?"
            } else{
                str = "This maxes out your \"wants\" budget. It's doable, but are you ok with zero wiggle room?"
            }
        }
    }
    
}

//var text = Finance(totalIncome: 100)




