//
//  APIConstants.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 03/02/2025.
//

import Foundation

public struct APIConstants {
    private static var baseURLString: String = "http://127.0.0.1:8080/api/v1/"
    
    public static func registerAccount() -> URL {
        return createURL(endpoint: "auth/register")
    }
    
    public static func verifyOTP() -> URL {
        return createURL(endpoint: "auth/register/verify-otp")
    }
    
    public static func resendOTP() -> URL {
        return createURL(endpoint: "auth/register/resend-otp")
    }
    
    public static func loginAccount() -> URL {
        return createURL(endpoint: "auth/login")
    }
    
    public static func sendOTP() -> URL {
        return createURL(endpoint: "auth/forgot-password/send-otp-to-email")
    }
    
    public static func setNewPassword() -> URL {
        return createURL(endpoint: "auth/forgot-password/verify-and-set-password")
    }
    
    public static func refreshToken() -> URL {
        return createURL(endpoint: "refresh")
    }
    
    public static func getUserProfile() -> URL {
        return createURL(endpoint: "user")
    }
    
    public static func logoutAccount() -> URL {
        return createURL(endpoint: "user/logout")
    }
    
    private static func createURL(endpoint: String) -> URL {
        guard let url = URL(string: baseURLString + endpoint) else {
            fatalError("Invalid URL: \(baseURLString + endpoint)")
        }
        return url
    }
}
