//
//  ResponseError.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 03/02/2025.
//


public enum ResponseError: Error {
    case invalidURL
    case requestFailed
    case responseError(statusCode: Int)
    case dataParsingError
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case verifyOTPError
    case registerAccountError
    case resendOTPError
    case loginError
    case sendOTPError
    case setNewPasswordError
    case refreshTokenError
    case getUserProfileError
    case logoutError
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The provided URL is invalid."
        case .requestFailed:
            return "The request failed. Please try again."
        case .responseError(let statusCode):
            return "Received an error response with status code \(statusCode)."
        case .dataParsingError:
            return "Failed to parse the response data."
        case .unauthorized:
            return "Unauthorized access. Please login again."
        case .forbidden:
            return "You do not have permission to perform this action."
        case .notFound:
            return "Requested resource was not found."
        case .serverError:
            return "Server encountered an error. Please try again later."
        case .verifyOTPError:
            return "Error while verifying OTP. Please check the code and try again."
        case .registerAccountError:
            return "Error while registering account. Please try again later."
        case .resendOTPError:
            return "Error while resending OTP. Please try again later."
        case .loginError:
            return "Error while logging in. Please check your credentials and try again."
        case .sendOTPError:
            return "Error while sending OTP. Please try again later."
        case .setNewPasswordError:
            return "Error while setting new password. Please try again later."
        case .refreshTokenError:
            return "Error while refreshing token. Please try again later."
        case .getUserProfileError:
            return "Error while retrieving user profile. Please try again later."
        case .logoutError:
            return "Error while logging out. Please try again later."
        }
    }
}
