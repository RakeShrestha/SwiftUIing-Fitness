//
//  BaseViewModel.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 03/02/2025.
//

import Foundation

class BaseViewModel {
    
    var errorFromAPI: ((String) -> Void)?
    
    var authErrorFromAPI: ((String) -> Void)?
    
    
    public func checkErrorType(errorGot: CustomError?) -> Bool {
        if errorGot?.localizedDescription == CustomError.authorizationFailed.localizedDescription {
            return true
        }
        return false
    }
}
