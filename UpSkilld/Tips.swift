//
//  Tips.swift
//  UpSkilld
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct Tips: View {
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .allowsHitTesting(false)
            Text("Welcome to beginner tips!")
        }
    }
}

#Preview {
    Tips()
}
