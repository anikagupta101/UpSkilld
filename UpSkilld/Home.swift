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
                    Text("UpSkilld")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.trailing)
                    .toolbar {
                        NavigationLink("Finances", destination: Finances())
                            .fontWeight(.bold)
                            .padding()
                            
                        NavigationLink("Invest", destination: Invest())
                            .fontWeight(.bold)
                            .padding()
                        NavigationLink("Ups", destination: ShortFormContent())
                            .fontWeight(.bold)
                            .padding(.trailing, 70.0)
                            
                            
                    }
                    
                    .multilineTextAlignment(.center)
                    
                    Text("Home Screen")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    
                }
             
                .padding()
            }
        }
    }
}

#Preview {
    Home()
}
