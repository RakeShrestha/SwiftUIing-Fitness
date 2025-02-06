//
//  AuthViewModel.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 31/01/2025.
//

import Foundation

class LoginViewModel: BaseViewModel {
    
    public func loginUser(email: String, password: String) {
        let loginService = GetLoginToken(client: URLSessionHTTPClient(), url: APIConstants.loginAccount(), token: nil)
        let loginRequest = LoginRequest(email: email, password: password, fcMToken: "")

        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(loginRequest)
            loginService.post(data: jsonData) { [weak self] results in
                guard let self = self else { return }
                do {
                    let response = try results.get()
                    print(response)
                    guard let response = response else {
                        return
                    }
                } catch let error {
                    if self.checkErrorType(errorGot: error as? CustomError) {
                        print(error)
                    } else {
                        self.errorFromAPI?(ResponseError.loginError.localizedDescription)
                    }
                }
            }
        } catch {
            self.errorFromAPI?(ResponseError.loginError.localizedDescription)
        }
    }


}

class SignupViewModel: BaseViewModel {
    
    public func getOTP(firstName: String, secondName: String, email: String, password: String) {
        let otpService = GetSignupResponse(client: URLSessionHTTPClient(), url: APIConstants.registerAccount(), token: nil)
        let otpRequest = OTPRequest(firstName: "Nikel", secondName: "Maharjan", email: "nikel@test.com", password: "Nikel@123")

        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(otpRequest)
            otpService.post(data: jsonData) { [weak self] results in
                guard let self = self else { return }
                do {
                    let response = try results.get()
                    print(response)
                    guard let response = response else {
                        return
                    }
                } catch let error {
                    if self.checkErrorType(errorGot: error as? CustomError) {
                        print(error)
                    } else {
                        self.errorFromAPI?(ResponseError.loginError.localizedDescription)
                    }
                }
            }
        } catch {
            self.errorFromAPI?(ResponseError.loginError.localizedDescription)
        }
    }


}

class OTPViewModel: BaseViewModel {
    
    public func verifyOTP(email: String, otp: String) {
        let verifyOTPService = VerifyOTPRequest(client: URLSessionHTTPClient(), url: APIConstants.verifyOTP(), token: nil)
        let verifyOTPRequest = VerifyOTP(email: "nikel@test.com", otp: otp)

        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(verifyOTPRequest)
            verifyOTPService.post(data: jsonData) { [weak self] results in
                guard let self = self else { return }
                do {
                    let response = try results.get()
                    print(response)
                    guard let response = response else {
                        return
                    }
                } catch let error {
                    if self.checkErrorType(errorGot: error as? CustomError) {
                        print(error)
                    } else {
                        self.errorFromAPI?(ResponseError.loginError.localizedDescription)
                    }
                }
            }
        } catch {
            self.errorFromAPI?(ResponseError.loginError.localizedDescription)
        }
    }


}
