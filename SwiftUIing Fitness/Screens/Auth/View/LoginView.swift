//
//  LoginView.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 31/01/2025.
//

import SwiftUI

struct LoginView: View {
    
    private var viewModel = LoginViewModel()
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    
    @State private var isPasswordVisible: Bool = false
    
    @State private var isSignUpScreenPresented: Bool = false
    
    @State private var loginViewOpacity: Double = 1.0
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
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    
                    signInImage
                    
                    textFieldView
                    
                    signInButton
                    
                    dividerView
                    
                    appleSignInButton
                    
                    googleSignInButton
                    
                    signUpButtonWithText
                    
                    forgotPasswordButton
                    
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
                .opacity(isSignUpScreenPresented ? 0 : loginViewOpacity)
                .animation(.easeOut(duration: 0.5), value: loginViewOpacity)
            }
            .background(Color.black)
            .ignoresSafeArea()
            .onTapGesture {
                hideKeyboard()
            }
            .fullScreenCover(isPresented: $isSignUpScreenPresented) {
                SignupView()
            }
            .onChange(of: isSignUpScreenPresented) {
                if !isSignUpScreenPresented {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                        withAnimation(.easeOut) {
                            loginViewOpacity = 1
                        }
                    }
                }
            }
        }
    }
    
    private func hideKeyboard() {
        isEmailFocused = false
        isPasswordFocused = false
    }
    
    private var signInImage: some View {
        CustomLoginSignUpImage(title: "Sign In to Fitness App", subtitle: "Let’s personalize your fitness with AI", customImage: "loginImage")
    }
    
    private var textFieldView: some View {
        VStack {
            // Email Field
            TextFieldWithIcon(title: "Email Address", icon: "email", placeholder: "Enter your email", text: $email, isFocused: _isEmailFocused)
                .submitLabel(.next)
                .onSubmit {
                    isPasswordFocused = true
                }
            
            // Password Field
            PasswordFieldWithIcon(title: "Password", placeholder: "Password", password: $password, isFocused: _isPasswordFocused, isPasswordVisible: $isPasswordVisible)
                .submitLabel(.done)
        }
    }
    
    private var signInButton: some View {
        // Sign In Button
        ActionButton(label: "Login", icon: "arrowRight") {
            // Handle login action here
            viewModel.loginUser(email: email, password: password)
        }
    }
    
    private var dividerView: some View {
        HStack {
            Divider()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .background(.white.opacity(0.5))
            
            Text("or")
                .font(.callout)
                .fontWeight(.semibold)
            
            Divider()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .background(.white.opacity(0.5))
        }
        .foregroundStyle(.white)
    }
    
    private var appleSignInButton: some View {
        Button(action: {
            // Handle Apple sign-in
        }) {
        }
        .buttonStyle(SignInButtonStyle(image: Image(systemName: "apple.logo"), title: "Sign in with Apple"))
    }
    
    private var googleSignInButton: some View {
        Button(action: {
            // Handle Google sign-in
        }) {
        }
        .buttonStyle(SignInButtonStyle(image: Image("google"), title: "Sign in with Google"))
    }
    
    private var signUpButtonWithText: some View {
        HStack {
            Text("Don't have an account?")
                .font(.footnote)
                .fontWeight(.heavy)
                .foregroundStyle(.white)
            
            Button {
                withAnimation {
                    loginViewOpacity = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    isSignUpScreenPresented = true
                }
            } label: {
                Text("Sign up")
                    .font(.footnote)
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.init(hex: "F97316"))
                    .underline(color: Color.init(hex: "F97316"))
            }
        }
    }
    
    private var forgotPasswordButton: some View {
        NavigationLink( destination: ForgotPasswordView()) {
            Text("Forgot Password")
                .font(.footnote)
                .fontWeight(.heavy)
                .foregroundStyle(Color.init(hex: "F97316"))
                .underline(color: Color.init(hex: "F97316"))
        }
        .padding(.bottom, 32)
    }
    
}

#Preview {
    LoginView()
}
