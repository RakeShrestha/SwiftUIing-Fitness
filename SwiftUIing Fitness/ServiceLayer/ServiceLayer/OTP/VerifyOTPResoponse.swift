//
//  VerifyOTPResoponse.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 06/02/2025.
//

import Foundation

// MARK: - LoginResponse
public struct VerifyOTPResoponse: Codable {
    let data: VerifyOTPData?
    let errors: [String]?
    let message: String?
}

// MARK: - DataClass
public struct VerifyOTPData: Codable {
    let accessToken, refreshToken: String
}
