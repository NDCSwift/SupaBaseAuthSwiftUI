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

struct LoginView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        
        TextField("Email", text: $email)
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
        
        SecureField("password", text: $password)
            .textFieldStyle(.roundedBorder)
        
        Button("Sign In"){
            Task{
                await authViewModel.signIn(email: email, password: password)
            }
        }
        .buttonStyle(.borderedProminent)

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
