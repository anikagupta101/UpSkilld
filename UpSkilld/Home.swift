//
//  Home.swift
//  UpSkilld
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundImage")
                    .resizable()
                    //.scaledToFill()
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                VStack {
                    Text("Home Screen")
                        .font(.largeTitle)
                    
                    NavigationLink("Finances", destination: Finances())
                    NavigationLink("Invest", destination: Invest())
                }
                .padding()
            }
        }
    }
}

#Preview {
    Home()
}
