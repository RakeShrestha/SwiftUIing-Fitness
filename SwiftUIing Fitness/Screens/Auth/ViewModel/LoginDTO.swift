//
//  LoginDTO.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 03/02/2025.
//

import Foundation

public struct LoginRequest: Codable {
    public let email: String
    public let password: String
    public let fcmToken: String

    enum CodingKeys: String, CodingKey {
        case email
        case password
        case fcmToken
    }

    public init(email: String, password: String, fcMToken: String) {
        self.email = email
        self.password = password
        self.fcmToken = fcMToken
    }
}
