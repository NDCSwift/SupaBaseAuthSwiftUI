//
    // Project: SupaBaseAuthSwiftUI
    //  File: AuthViewModel.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    

import SwiftUI
import Supabase
import Combine


@MainActor
class AuthViewModel: ObservableObject {
    @Published var session: Session?
    @Published var isAuthenticated = false
    
    func getInitialSession() async {
        do {
            let current = try await supabase.auth.session
            self.session = current
            self.isAuthenticated = current != nil
        } catch {
            print("No active session: \(error.localizedDescription)")
        }
    }
    
    func signUp(email: String, password: String) async {
        do {
            let result = try await supabase.auth.signUp(email: email, password: password)
            self.session = result.session
            self.isAuthenticated = self.session != nil
        } catch {
            print("Sign-up failed: \(error.localizedDescription)")
        }
    }
    
    func signIn(email: String, password: String) async {
        do {
            let signInresult = try await supabase.auth.signIn(email: email, password: password)
            self.session = signInresult
            self.isAuthenticated = self.session != nil
        } catch {
            print("Sign-in failed: \(error.localizedDescription)")
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
