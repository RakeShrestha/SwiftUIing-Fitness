//
//  ForgetPasswordView.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 31/01/2025.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email = ""
    @State private var newPassword = ""
    
    @State private var isPasswordVisible: Bool = false
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isNewPasswordFocused: Bool
    
    let receivedOTP = "1234"
    @State private var otpReceived: Bool = false
    @State private var enteredOTP: String = ""
    @State private var didOTPMatched: Bool = true
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                BackButton()
                
                headerView
                emailInputField
                passwordInputField
                otpSection
                if !didOTPMatched {
                    errorMessageView
                }
                Spacer()
                actionButton
            }
            .padding(.all, 24)
        }
        .background(.black)
        .onTapGesture {
            hideKeyboard()
        }
        .navigationBarBackButtonHidden()
    }
}

private extension ForgotPasswordView {
    
    private func hideKeyboard() {
           isEmailFocused = false
           isNewPasswordFocused = false
       }
    
    // MARK: - Header View
    var headerView: some View {
        Text("Reset Password")
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.bottom, 28)
    }
    
    // MARK: - Email Input Field
    var emailInputField: some View {
        TextFieldWithIcon(
            title: "Email Address",
            icon: "email",
            placeholder: "Enter your email",
            text: $email,
            isFocused: _isEmailFocused
        )
        .submitLabel(.next)
        .onSubmit {
            isNewPasswordFocused = true
        }
    }
    
    // MARK: - Password Input Field
    var passwordInputField: some View {
        PasswordFieldWithIcon(
            title: "Password",
            placeholder: "Password",
            password: $newPassword,
            isFocused: _isNewPasswordFocused,
            isPasswordVisible: $isPasswordVisible
        )
        .submitLabel(.done)
    }
    
    // MARK: - OTP Section
    var otpSection: some View {
        Group {
            if otpReceived {
                otpEntryView
            }
        }
    }
    
    // MARK: - OTP Entry View
    var otpEntryView: some View {
        VStack(alignment: .leading) {
            Text("Enter OTP")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 24)
            
            HStack(alignment: .center) {
                Spacer()
                OTPTextField(numberOfPinFields: 4, enteredOTP: $enteredOTP)
                Spacer()
            }
            .padding(.top, 4)
        }
    }
    
    // MARK: - Action Button
    var actionButton: some View {
        VStack {
            if otpReceived {
                otpConfirmButton
            } else {
                sendOTPButton
            }
        }
    }
    
    private var errorMessageView : some View {
            ErrorMessage(message: "ERROR: OTP does not match")
    }
    
    // MARK: - Send OTP Button
    var sendOTPButton: some View {
        ActionButton(label: "Send OTP", icon: "arrowRight") {
            withAnimation {
                otpReceived = true
            }
        }
    }
    
    // MARK: - OTP Confirm Button
    var otpConfirmButton: some View {
        Button {
            handleOTPVerification()
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
        .background(
            enteredOTP.count == 4
            ? Capsule().fill(Color.init(hex: "F97316"))
            : Capsule().fill(Color.gray.opacity(0.2))
        )
        .padding(.vertical, 12)
        .disabled(enteredOTP.count != 4)
    }
    
    // MARK: - OTP Verification Handling
    func handleOTPVerification() {
        if verifyOTP() {
            print("OTP Verified Successfully!")
            dismiss()
        } else {
            withAnimation {
                didOTPMatched = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    didOTPMatched = true
                }
            }
        }
    }
    
    // MARK: - OTP Verification Logic
    func verifyOTP() -> Bool {
        return enteredOTP == receivedOTP
    }
}

#Preview {
    ForgotPasswordView()
}
