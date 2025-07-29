//
//  ContentView.swift
//  UpSkilld
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home Screen")
                    .font(.largeTitle)
                
                NavigationLink("Finances", destination: Finances())
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
