//
//  SignupDTO.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 05/02/2025.
//

import Foundation

public struct OTPRequest: Codable {
    public let firstName: String
    public let secondName: String
    public let email: String
    public let password: String

    enum CodingKeys: String, CodingKey {
        case firstName
        case secondName
        case email
        case password
    }

    public init(firstName: String, secondName: String, email: String, password: String) {
        self.firstName = firstName
        self.secondName = secondName
        self.email = email
        self.password = password
    }
}
