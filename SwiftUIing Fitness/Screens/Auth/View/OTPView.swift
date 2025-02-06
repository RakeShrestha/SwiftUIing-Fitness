//
//  OTPView.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 31/01/2025.
//

import SwiftUI

struct OTPView: View {
    let receivedOTP = "1234"
    let viewModel = OTPViewModel()
    let email: String
    let password: String
    @State private var enteredOTP: String = ""
    @State private var didOTPMatched : Bool = true
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    
                    BackButton()
                    
                    headerView
                    
                    otpFieldView
                    
                    if !didOTPMatched {
                        errorMessageView
                    }
                    
                    Spacer()
                    
                    confirmButtonView
                }
                
                footerView
            }
            .padding(.all, 32)
        }
        .background(.black)
        .navigationBarBackButtonHidden()
        
    }
    
    func verifyOTP() -> Bool {
        return enteredOTP == receivedOTP
    }
    
    private var headerView : some View {
        VStack(alignment: .leading) {
            Text("Verification Code")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            Text("We have sent the verification code to your email address")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.white.opacity(0.7))
        }
    }
    
    private var otpFieldView : some View {
        HStack(alignment: .center) {
            Spacer()
            OTPTextField(numberOfPinFields: 6, enteredOTP: $enteredOTP)
            Spacer()
        }
    }
    
    private var confirmButtonView : some View {
        Button {
            if verifyOTP() {
                // OTP matches
            } else {
                // OTP does not match
                viewModel.verifyOTP(email: "", otp: enteredOTP)
                withAnimation {
                    didOTPMatched = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    withAnimation {
                        didOTPMatched = true
                    }
                })
            }
        } label: {
            HStack {
                Text("Confirm")
                    .foregroundStyle(Color.white)
                    .padding(.vertical)
                
                Image("arrowRight")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 4)
            }
        }
        
        .frame(maxWidth: .infinity, alignment: .center)
        .background(enteredOTP.count == 6 ? Capsule().fill(Color.init(hex: "F97316")) : Capsule().fill(Color.gray.opacity(0.2)))
        .padding(.vertical, 12)
        .disabled(enteredOTP.count != 6)
    }
    
    private var footerView : some View {
        HStack {
            Text("Didn't receive code?")
                .font(.subheadline)
                .foregroundStyle(.white)
            Button {
                
            } label: {
                Text("Request again")
                    .foregroundStyle(Color.init(hex: "F97316"))
            }
        }
        .padding(.bottom, 12)
    }
    
    private var errorMessageView : some View {
        ErrorMessage(message: "ERROR: OTP does not match")
    }
    
}

#Preview {
    OTPView(email: "testEmail@test.com", password: "Test@1234")
}
