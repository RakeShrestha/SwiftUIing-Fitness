//
//  HTTPURLResponse+StatusCode.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 03/02/2025.
//

import Foundation

extension HTTPURLResponse {
    
    private static var OK200: Int { return 200 }
    private static var UNAUTHORIZED: Int { return 401 }
    
    public var isOK: Bool {
        return statusCode == HTTPURLResponse.OK200
    }
    
    public var isUnauthorized: Bool {
        return statusCode == HTTPURLResponse.UNAUTHORIZED
    }
    
}
