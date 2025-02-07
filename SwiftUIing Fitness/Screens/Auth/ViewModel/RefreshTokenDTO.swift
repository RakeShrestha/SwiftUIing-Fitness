//
//  RefreshTokenDTO.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 07/02/2025.
//

import Foundation

public struct RefreshToken: Codable {
    public let refreshToken: String
    public let accessToken: String

    enum CodingKeys: String, CodingKey {
        case refreshToken
        case accessToken
    }

    public init(refreshToken: String, accessToken: String) {
        self.refreshToken = refreshToken
        self.accessToken = accessToken
    }
}
