//
//  Invest.swift
//  UpSkilld
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct Invest: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: Tutorials()) {
                    Text("Tutorials button")
                        .font(.title)
                        .fontWeight(.semibold)
                } //closes NavigationLink
                NavigationLink(destination: Resources()) {
                    Text("Resources button")
                        .font(.title)
                        .fontWeight(.semibold)
                } //closes NavigationLink
                
                //code for beginner tips, tutorials navigation, and resources navigation
                
            } //closes VStack
        } //closes NavigationStack
    } //closes var body
} //closes struct

#Preview {
    Invest()
}
