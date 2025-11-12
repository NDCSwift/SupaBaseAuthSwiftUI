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
/// View model responsible for handling authentication state and actions using Supabase.
class AuthViewModel: ObservableObject {
    /// The current authenticated session if available. Nil when logged out or pending email confirmation.
    @Published var session: Session?
    /// Convenience flag derived from whether a valid session exists.
    @Published var isAuthenticated = false
    /// Prevents duplicate requests while an auth operation is in flight.
    @Published var isLoading = false
    
    func getInitialSession() async {
        // Attempt to restore an existing session on app launch (e.g., from persisted credentials).
        do {
            let current = try await supabase.auth.session
            self.session = current
            self.isAuthenticated = current != nil
        } catch {
            // If no session is available, explicitly reset state.
            print("No active session: \(error.localizedDescription)")
            self.session = nil
            self.isAuthenticated = false
        }
    }
    
    func signUp(email: String, password: String) async {
        // Create a new user account. Depending on Supabase settings, email confirmation may be required.
        do {
            // Debounce repeated taps while a request is already in progress.
            guard !isLoading else { return }
            isLoading = true
            defer { isLoading = false }

            // Perform sign-up; response.session can be nil if email confirmation is enabled.
            let response = try await supabase.auth.signUp(email: email, password: password)
            // Persist the returned session (if any) and update auth state.
            self.session = response.session
            self.isAuthenticated = self.session != nil
            // Keep the previous logging style for consistency (will be "present" on success).
            print("SignUp: session is \(self.session == nil ? "nil" : "present")")
        } catch {
            // Surface a readable error and reset state on failure.
            print("Sign-up failed: \(error.localizedDescription)")
            self.session = nil
            self.isAuthenticated = false
        }
    }
    
    func signIn(email: String, password: String) async {
        // Sign in an existing user with email/password and update session.
        do {
            // Avoid overlapping sign-in attempts.
            guard !isLoading else { return }
            isLoading = true
            defer { isLoading = false }

            // On success, Supabase returns a non-optional Session.
            let session = try await supabase.auth.signIn(email: email, password: password)
            // Store the active session so the UI can react.
            self.session = session
            // Mark the user as authenticated since sign-in succeeded.
            self.isAuthenticated = true
            // Keep the previous logging style for consistency (will be "present" on success).
            print("SignIn: session is \(self.session == nil ? "nil" : "present")")
            
        } catch {
            // Reset to a clean unauthenticated state if sign-in fails.
            print("Sign-in failed: \(error.localizedDescription)")
            self.session = nil
            self.isAuthenticated = false
        }
    }
    
    func signOut() async {
        // Clear the server-side session and update local state.
        do {
            try await supabase.auth.signOut()
            self.session = nil
            self.isAuthenticated = false
        } catch {
            // Log sign-out errors but keep the UI responsive.
            print("Sign-out failed: \(error.localizedDescription)")
        }
    }
}


