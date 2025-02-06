//
//  CustomTextField.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 31/01/2025.
//

import SwiftUI

struct TextFieldWithIcon: View {
    let title: String
    let icon: String?
    let placeholder: String
    @Binding var text: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(.leading, 8)
            
            HStack {
                if let icon = icon {
                    Image(icon)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 4)
                }
                TextField("", text: $text, prompt: Text(placeholder).foregroundStyle(.white.opacity(0.5)))
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .tint(Color.white)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .focused($isFocused)
            }
            .padding()
            .background(Color(hex: "111214"))
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(
                        isFocused ? Color.init(hex: "F97316") .opacity(0.4) : Color.clear, lineWidth: 5.5
                    )
                    .padding(-5)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isFocused)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(isFocused ? Color.init(hex: "F97316") : Color.clear, lineWidth: 2)
                    .animation(.easeInOut(duration: 0.3), value: isFocused)
            )
        }
    }
}

struct PasswordFieldWithIcon: View {
    let title: String
    let placeholder: String
    @Binding var password: String
    @FocusState var isFocused: Bool
    @Binding var isPasswordVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(.leading, 8)
                .padding(.top, 8)
            
            HStack {
                Image("password")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 4)
                
                if isPasswordVisible {
                    TextField("", text: $password, prompt: Text(placeholder).foregroundStyle(.white.opacity(0.5)))
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .focused($isFocused)
                } else {
                    SecureField("", text: $password, prompt: Text(placeholder).foregroundStyle(.white.opacity(0.5)))
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .focused($isFocused)
                }
                
                Image("showPassword")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 8)
                    .onTapGesture {
                        isPasswordVisible.toggle()
                    }
            }
            .padding()
            .background(Color(hex: "111214"))
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(
                        isFocused ? Color.init(hex: "F97316") .opacity(0.4) : Color.clear, lineWidth: 5.5
                    )
                    .padding(-5)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isFocused)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(isFocused ? Color.init(hex: "F97316") : Color.clear, lineWidth: 2)
                    .animation(.easeInOut(duration: 0.3), value: isFocused)
            )
        }
    }
}

struct OTPTextField: View {
    let numberOfPinFields: Int
    @State private var enterValue: [String]
    @FocusState private var fieldFocus: Int?
    @State private var oldValue = ""
    
    @Binding var enteredOTP: String
    
    init(numberOfPinFields: Int, enteredOTP: Binding<String>) {
        self.numberOfPinFields = numberOfPinFields
        self._enteredOTP = enteredOTP
        _enterValue = State(initialValue: Array(repeating: "", count: numberOfPinFields))
    }
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(0..<numberOfPinFields, id: \.self) { index in
                OTPTextFieldCell(
                    text: $enterValue[index],
                    index: index,
                    fieldFocus: $fieldFocus,
                    oldValue: $oldValue,
                    numberOfPinFields: numberOfPinFields
                )
            }
        }
        .onChange(of: enterValue) { _ in
            enteredOTP = enterValue.joined()
        }
    }
}

struct OTPTextFieldCell: View {
    @Binding var text: String
    let index: Int
    @FocusState.Binding var fieldFocus: Int? // Use FocusState.Binding
    @Binding var oldValue: String
    let numberOfPinFields: Int
    
    var body: some View {
        TextField("", text: $text, onEditingChanged: { editing in
            if editing {
                oldValue = text
            }
        })
        .frame(width: UIScreen.main.bounds.width / 8.5,
               height: UIScreen.main.bounds.width / 8.5)
        .background(Color(hex: "393C43").opacity(0.5))
        .cornerRadius(16)
        .multilineTextAlignment(.center)
        .keyboardType(.numberPad)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .strokeBorder(
                    fieldFocus == index
                    ? Color(hex: "F97316").opacity(0.4)
                    : Color.clear,
                    lineWidth: 5.5
                )
                .padding(-5)
                .animation(.spring(response: 0.5, dampingFraction: 0.6),
                           value: fieldFocus)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(fieldFocus == index ? Color(hex: "F97316") : Color.clear,
                        lineWidth: 2)
                .animation(.easeInOut(duration: 0.3), value: fieldFocus)
        )
        .focused($fieldFocus, equals: index) // Focuses this specific field
        .onChange(of: text) { newValue in
            // Ensure only one character is entered
            if text.count > 1 {
                if text.first == Character(oldValue) {
                    text = String(text.suffix(1))
                } else {
                    text = String(text.prefix(1))
                }
            }
            
            // Adjust focus behavior based on new value
            if !newValue.isEmpty {
                if fieldFocus == numberOfPinFields - 1 {
                    fieldFocus = nil
                } else {
                    fieldFocus = (fieldFocus ?? 0) + 1
                }
            } else {
                fieldFocus = (fieldFocus ?? 0) - 1
            }
        }
    }
}
