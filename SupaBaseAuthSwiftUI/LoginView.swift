//
    // Project: SupaBaseAuthSwiftUI
    //  File: LoginView.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    

import SwiftUI

/// Simple email/password sign-in and sign-up form.
struct LoginView: View {
    /// Reference to the shared auth view model for performing actions.
    @ObservedObject var authViewModel: AuthViewModel
    /// Local input state for the email field.
    @State private var email = ""
    /// Local input state for the password field.
    @State private var password = ""
    var body: some View {
        
        // Capture the user's email address.
        TextField("Email", text: $email)
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
        
        // Capture the user's password.
        SecureField("password", text: $password)
            .textFieldStyle(.roundedBorder)
        
        // Trigger sign-in using the provided credentials.
        Button("Sign In"){
            Task{
                await authViewModel.signIn(email: email, password: password)
            }
        }
        .buttonStyle(.borderedProminent)

        // Optionally create a new account with the same inputs.
        Button("Sign up"){
            Task{
                await authViewModel.signUp(email: email, password: password)
            }
        }
        .buttonStyle(.bordered)
        
        
    }
}

//#Preview {
//    LoginView()
//}

