//
//  SignupResponse.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 05/02/2025.
//

import Foundation

// MARK: - LoginResponse
public struct SignupResponse: Codable {
    let errors: [String]?
    let message: String?
}
