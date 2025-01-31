//
//  OnboardingScreen.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 31/01/2025.
//

import SwiftUI

struct OnboardingScreen2: View {
    
    @State private var onboardingScreenCount = 0
    @State private var isButtonEnabled = true
    
    let onboardingContent = [
        OnboardingContent(imageName: "onboarding1", title: "Welcome To", subtitle: " Fitness App!", description: "Look Good, Feel Good!"),
        OnboardingContent(imageName: "onboarding2", title: "Personalized", subtitle: " Fitness Plans!", description: "Choose your own fitness journey!"),
        OnboardingContent(imageName: "onboarding3", title: "Extensive Workout", subtitle: "Libraries", description: "Explore ~100K exercises made for you! 💪"),
        OnboardingContent(imageName: "onboarding4", title: "Health Metrics &", subtitle: "Fitness Analytics", description: "Monitor your health profile with ease. 📈"),
        OnboardingContent(imageName: "onboarding5", title: "Nutrition & Diet", subtitle: "Guidance", description: "Lose weight and get fit with sandow! 🥒"),
        OnboardingContent(imageName: "onboarding6", title: "Virtual Coach", subtitle: "Mentoring", description: "Say goodbye to manual coaching! 👋")
    ]
    
    var body: some View {
        ZStack {
            backgroundImage
            
            VStack(spacing: 24) {
                Spacer()
                textContent
                
                Group {
                    if onboardingScreenCount == 0 {
                        getStartedButton
                    } else {
                        navigationButtons
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 90)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(gradientOverlay)
        }
        .ignoresSafeArea()
    }
    
    private var backgroundImage: some View {
        ForEach(onboardingContent.indices, id: \.self) { index in
            if index == onboardingScreenCount {
                Image(onboardingContent[index].imageName)
                    .resizable()
                    .scaledToFill()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.8), value: onboardingScreenCount)
            }
        }
    }
    
    private var textContent: some View {
        ForEach(onboardingContent.indices, id: \.self) { index in
            if index == onboardingScreenCount {
                VStack(spacing: 16) {
                    VStack {
                        Text(onboardingContent[index].title)
                        Text(onboardingContent[index].subtitle)
                    }
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .transition(.slide)
                    .animation(.easeInOut(duration: 0.65), value: onboardingScreenCount)
                    
                    Text(onboardingContent[index].description)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.white)
                        .padding(.bottom, 32)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.65), value: onboardingScreenCount)
                }
            }
        }
    }
    
    private var getStartedButton: some View {
        ActionButton(label: "Get Started", icon: "arrowRight") {
            navigateToNextScreen()
        }
        .frame(width: 240)
    }
    
    private var navigationButtons: some View {
        HStack(spacing: 20) {
            ArrowButton(imageName: "arrowLeft", isDisabled: onboardingScreenCount == 0 || !isButtonEnabled) {
                navigateToPreviousScreen()
            }
            
            ArrowButton(imageName: "arrowRight", isDisabled: onboardingScreenCount == onboardingContent.count - 1 || !isButtonEnabled) {
                navigateToNextScreen()
            }
        }
    }
    
    private var gradientOverlay: some View {
        LinearGradient(
            colors: [Color.black.opacity(0), Color.black.opacity(0.6)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    private func navigateToPreviousScreen() {
        withAnimation {
            handleButtonClick {
                onboardingScreenCount -= 1
            }
        }
    }
    
    private func navigateToNextScreen() {
        withAnimation {
            handleButtonClick {
                onboardingScreenCount += 1
            }
        }
    }
    
    private func handleButtonClick(action: @escaping () -> Void) {
        guard isButtonEnabled else { return }
        isButtonEnabled = false
        action()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            isButtonEnabled = true
        }
    }
}

#Preview {
    OnboardingScreen2()
}
