//
//  ResendOTPDTO.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 07/02/2025.
//

import Foundation

public struct ResendOTP: Codable {
    public let email: String

    enum CodingKeys: String, CodingKey {
        case email
    }

    public init(email: String) {
        self.email = email
    }
}
