//
//  CustomOnboardingArrowButton.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 31/01/2025.
//

import SwiftUI

struct ArrowButton: View {
    let imageName: String
    let isDisabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            if !isDisabled {
                action()
            }
        }) {
            Image(imageName)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.all, 20)
        }
        .frame(height: 80, alignment: .center)
        .frame(maxWidth: .infinity)
        .background(Capsule().fill(Color(hex: "393C43")))
        .disabled(isDisabled)
    }
}
