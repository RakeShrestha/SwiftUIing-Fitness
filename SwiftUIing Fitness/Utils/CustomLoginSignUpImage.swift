//
//  CustomLoginSignUpImage.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 31/01/2025.
//

import SwiftUI

struct CustomLoginSignUpImage: View {
    let title: String
    let subtitle: String
    let customImage: String
    
    var body: some View {
        ZStack {
            Image(customImage)
                .resizable()
                .scaledToFit()
                .overlay(
                    VStack {
                        Spacer()
                        Text(title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.bottom, 4)
                        
                        Text(subtitle)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                    }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.bottom, 40)
                        .background(RadialGradient(colors: [Color.black.opacity(0.06), Color.black.opacity(0.7)], center: .bottom, startRadius: 300, endRadius: 50))
                )
        }
    }
}
