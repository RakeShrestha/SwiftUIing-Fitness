//
//  CustomActionButton.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 31/01/2025.
//

import SwiftUI

struct ActionButton: View {
    let label: String
    let icon: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(label)
                    .foregroundStyle(Color.white)
                    .padding(.vertical)
                
                Image(icon)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 4)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Capsule().fill(Color.init(hex: "F97316")))
        }
        .padding(.vertical, 12)
    }
}


// Custom Back Button View
struct BackButton: View {
    // Environment variable to handle back navigation
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image("backArrow")
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .padding(.all, 10)
        }
        .background(Color.init(hex: "393C43"))
        .cornerRadius(10)
        .padding(.bottom, 20)
    }
}
