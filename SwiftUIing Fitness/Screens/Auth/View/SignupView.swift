//
//  SignupView.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 31/01/2025.
//

import SwiftUI

struct SignupView: View {
    
    @Environment(\.dismiss) var dismiss
    
    private let viewModel = SignupViewModel()
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @FocusState private var isFirstNameFocused: Bool
    @FocusState private var isLastNameFocused: Bool
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    @FocusState private var isConfirmPasswordFocused: Bool
    
    @State private var isPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    
    @State private var didPasswordMatch: Bool = true
    @State private var navigateToForgotPassword: Bool = false
    
    // State to track keyboard height
    @State private var keyboardHeight: CGFloat = 0
    
    // Listen to keyboard notifications
    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: .main
        ) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                // Update the keyboard height
                withAnimation {
                    self.keyboardHeight = keyboardFrame.height
                }
            }
        }
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: .main
        ) { _ in
            // Reset keyboard height when it hides
            withAnimation {
                self.keyboardHeight = 0
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center, spacing: 20) {
                        
                        signUpImageView
                        
                        textFields
                        
                        signUpButton
                        
                        signInButtonWithText
                    }
                    .padding(.horizontal)
                    .padding(.bottom, keyboardHeight) // Adjust the bottom padding for the keyboard
                    .onAppear {
                        // Subscribe to keyboard notifications when the view appears
                        subscribeToKeyboardNotifications()
                    }
                    .onDisappear {
                        // Remove the observers when the view disappears
                        NotificationCenter.default.removeObserver(self)
                    }
                }
                .background(Color.black)
                .ignoresSafeArea()
                .onTapGesture {
                    hideKeyboard()
                }
                .navigationDestination(isPresented: $navigateToForgotPassword) {
                    OTPView(email: email, password: password)
                }
            }
        }
    }
    
    private func hideKeyboard() {
        isFirstNameFocused = false
        isLastNameFocused = false
        isEmailFocused = false
        isPasswordFocused = false
        isConfirmPasswordFocused = false
    }
    
    private var signUpImageView: some View {
        CustomLoginSignUpImage(title: "Sign Up For Free", subtitle: "Get Started", customImage: "loginImage")
    }
    
    private var textFields: some View {
        VStack {
            // User Name
            HStack(alignment: .bottom, spacing: 24) {
                TextFieldWithIcon(title: "Your Name", icon: nil, placeholder: "First name", text: $firstName, isFocused: _isFirstNameFocused)
                    .submitLabel(.next)
                    .onSubmit {
                        isLastNameFocused = true
                    }
                TextFieldWithIcon(title: "", icon: nil, placeholder: "Last name", text: $lastName, isFocused: _isLastNameFocused)
                    .submitLabel(.next)
                    .onSubmit {
                        isEmailFocused = true
                    }
            }
            
            // Email Field
            TextFieldWithIcon(title: "Email Address", icon: "email", placeholder: "Enter your email", text: $email, isFocused: _isEmailFocused)
                .submitLabel(.next)
                .onSubmit {
                    isPasswordFocused = true
                }
            
            // Password Field
            PasswordFieldWithIcon(title: "Password", placeholder: "Password", password: $password, isFocused: _isPasswordFocused, isPasswordVisible: $isPasswordVisible)
                .submitLabel(.next)
                .onSubmit {
                    isConfirmPasswordFocused = true
                }
            
            // Confirm Password Field
            PasswordFieldWithIcon(title: "Confirm Password", placeholder: "Confirm Password", password: $confirmPassword, isFocused: _isConfirmPasswordFocused, isPasswordVisible: $isConfirmPasswordVisible)
                .submitLabel(.done)
            
            // Password Match Error
            if !didPasswordMatch {
                ErrorMessage(message: "ERROR: Password does not match")
            }
        }
    }
    
    private var signUpButton: some View {
        // Sign Up Button
        ActionButton(label: "Sign Up", icon: "arrowRight") {
            if (!password.isEmpty && !confirmPassword.isEmpty) && (password != confirmPassword) {
                withAnimation {
                    didPasswordMatch = false
                }
            } else {
                // Handle sign-up action
                viewModel.getOTP(firstName: "", secondName: "", email: "", password: "")
                navigateToForgotPassword = true
            }
        }
    }
    
    private var signInButtonWithText: some View {
        HStack {
            Text("Already have an account?")
                .font(.footnote)
                .fontWeight(.heavy)
                .foregroundStyle(.white)
            
            Button {
                // Handle Sign In navigation here
                dismiss()
            } label: {
                Text("Sign In")
                    .font(.footnote)
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.init(hex: "F97316"))
                    .underline(color: Color.init(hex: "F97316"))
            }
        }
        .padding(.bottom, 24)
    }
}

#Preview {
    SignupView()
}
