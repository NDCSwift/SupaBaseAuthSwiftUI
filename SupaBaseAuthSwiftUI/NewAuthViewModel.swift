//
    // Project: SupaBaseAuthSwiftUI
    //  File: AuthViewModel 2.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    

// This is an alternate more advanced version of our AuthViewModel we had created.

import SwiftUI
import Supabase
import Combine

@MainActor
class NewAuthViewModel: ObservableObject {
    @Published var session: Session?
    @Published var isAuthenticated = false
    
    // Check existing session on app launch
    func getInitialSession() async {
        do {
            let current = try await supabase.auth.session
            self.session = current
            self.isAuthenticated = current != nil
        } catch {
            print("No active session: \(error.localizedDescription)")
            self.session = nil
            self.isAuthenticated = false
        }
    }

    // EMAIL CONFIRMATION NOTE:
    // If "Confirm email" is enabled in Supabase Auth settings,
    // signUp will NOT immediately create a session.
    // In that case, session will be nil until the user confirms via email.

    func signUp(email: String, password: String) async {
        do {
            try await supabase.auth.signUp(
                email: email,
                password: password
            )
            
            // Try to grab a session (will be nil if email confirmation is required)
            if let current = try? await supabase.auth.session {
                self.session = current
                self.isAuthenticated = true
            } else {
                self.session = nil
                self.isAuthenticated = false
                print("Sign-up succeeded, but no session yet (likely email confirmation flow).")
            }
        } catch {
            print("Sign-up failed: \(error.localizedDescription)")
        }
    }

    func signIn(email: String, password: String) async {
        do {
            try await supabase.auth.signIn(
                email: email,
                password: password
            )
            
            // After a successful sign-in, explicitly fetch the session
            let current = try await supabase.auth.session
            self.session = current
            self.isAuthenticated = true
        } catch {
            print("Sign-in failed: \(error.localizedDescription)")
            self.session = nil
            self.isAuthenticated = false
        }
    }

    func signOut() async {
        do {
            try await supabase.auth.signOut()
            self.session = nil
            self.isAuthenticated = false
        } catch {
            print("Sign-out failed: \(error.localizedDescription)")
        }
    }
}
