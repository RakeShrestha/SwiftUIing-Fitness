//
//  CustomSocialSignInButton.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 31/01/2025.
//

import SwiftUI

struct SignInButtonStyle: ButtonStyle {
    var image: Image?
    var title: String
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if let image = image {
                image
                    .resizable()
                    .frame(width: 22, height: 24)
                    .padding(.trailing, 4)
            }
            Text(title)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .foregroundStyle(.white)
        .background(configuration.isPressed ? Color.gray.opacity(0.2) : Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color(hex: "F97316"), lineWidth: 2)
        )
        .padding(.vertical, 12)
    }
}
