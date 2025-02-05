//
//  LoginResponse.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 03/02/2025.
//

import Foundation

// MARK: - LoginResponse
public struct LoginResponse: Codable {
    let data: LoginData?
    let errors: [String]?
    let message: String?
}

// MARK: - DataClass
public struct LoginData: Codable {
    let accessToken, refreshToken: String
}
