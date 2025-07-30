//
//  Quiz.swift
//  UpSkilld
//
//  Created by Scholar on 7/30/25.
//

import SwiftUI

struct Quiz: View {
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                //.scaledToFill()
                .ignoresSafeArea()
                .allowsHitTesting(false)
            Text("Welcome to quiz!")
        }
    }
}

#Preview {
    Quiz()
}
