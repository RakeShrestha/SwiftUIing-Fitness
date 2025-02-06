//
//  VerifyOTPDTO.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 06/02/2025.
//

import Foundation

public struct VerifyOTP: Codable {
    public let email: String
    public let otp: String

    enum CodingKeys: String, CodingKey {
        case email
        case otp
    }

    public init(email: String, otp: String) {
        self.email = email
        self.otp = otp
    }
}
