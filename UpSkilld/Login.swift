//
//  Login.swift
//  UpSkilld
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct Login: View {
    var body: some View {
        NavigationStack{
            ZStack {
                Image("backgroundImage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                VStack{
                    Text("Login")
                    Text("temp link to homepage:")
                    NavigationLink("Home", destination: Home())
                }
            }
        }
    }
}

#Preview {
    Login()
}
