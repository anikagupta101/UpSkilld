//
//  KeyboardExtension.swift
//  UpSkilld
//
//  Created by Scholar on 7/30/25.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct KeyboardExtension: View {
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    KeyboardExtension()
}


