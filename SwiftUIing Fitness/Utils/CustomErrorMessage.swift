//
//  CustomErrorMessage.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 31/01/2025.
//

import SwiftUI

struct ErrorMessage: View {
    let message: String
    
    var body: some View {
        HStack {
            Image("warning")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.leading, 16)
                .padding(.vertical, 12)
            
            Text(message)
                .font(.caption)
                .fontWeight(.heavy)
                .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Capsule().fill(Color.init(hex: "450A0A")))
        .padding(.top, 12)
    }
}
