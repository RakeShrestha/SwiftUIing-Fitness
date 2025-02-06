//
//  VerifyOTPRequest.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 06/02/2025.
//

import Foundation

open class VerifyOTPRequest: RemoteUploader<VerifyOTPResoponse?> {}

extension VerifyOTPRequest {
    
    public convenience init(client: HTTPClient, url: URL, token: String?) {
        self.init(client: client, url: url, mapper: Self.map, token: token)
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) throws -> VerifyOTPResoponse? {
        if response.isOK {
            do {
                let baseResponse = try JSONDecoder().decode(VerifyOTPResoponse.self, from: data)
                return baseResponse
            } catch DecodingError.dataCorrupted(let context) {
                print(context)
                throw CustomError.invalidData
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                throw CustomError.invalidData
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                throw CustomError.invalidData
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                throw CustomError.invalidData
            } catch {
                print("error: ", error)
                throw CustomError.invalidData
            }
        } else if response.statusCode > 299 {
            do {
                let baseResponse = try JSONDecoder().decode(VerifyOTPResoponse.self, from: data)
                return baseResponse
            } catch {
                print("Failed to decode error response")
                throw CustomError.authorizationFailed
            }
        } else if  response.isUnauthorized {
            throw CustomError.authorizationFailed
        } else {
            throw CustomError.invalidData
        }
        
    }
    
}

