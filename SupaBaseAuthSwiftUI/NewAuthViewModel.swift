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

/// An alternate, more advanced auth view model showing explicit session fetches and detailed flows.
@MainActor
class NewAuthViewModel: ObservableObject {
    /// The current Supabase session, if one exists.
    @Published var session: Session?
    /// Convenience flag indicating whether a user is signed in.
    @Published var isAuthenticated = false
    
    // Check existing session on app launch
    func getInitialSession() async {
        // Restore any existing session on launch to keep users signed in.
        do {
            let current = try await supabase.auth.session
            self.session = current
            self.isAuthenticated = current != nil
        } catch {
            // No cached/active session found; ensure UI reflects logged-out state.
            print("No active session: \(error.localizedDescription)")
            self.session = nil
            self.isAuthenticated = false
        }
    }

    // MARK: - Sign-up considerations
    // EMAIL CONFIRMATION NOTE:
    // If "Confirm email" is enabled in Supabase Auth settings,
    // signUp will NOT immediately create a session.
    // In that case, session will be nil until the user confirms via email.

    func signUp(email: String, password: String) async {
        // Create an account; session may be unavailable until email is confirmed depending on settings.
        do {
            // Perform the sign-up request with Supabase.
            try await supabase.auth.signUp(
                email: email,
                password: password
            )
            
            // Attempt to fetch a session after sign-up; will be nil for email-confirmation flows.
            if let current = try? await supabase.auth.session {
                self.session = current
                self.isAuthenticated = true
            } else {
                // No session yet — likely awaiting email confirmation.
                self.session = nil
                self.isAuthenticated = false
                print("Sign-up succeeded, but no session yet (likely email confirmation flow).")
            }
        } catch {
            // Log a human-readable error for debugging.
            print("Sign-up failed: \(error.localizedDescription)")
        }
    }

    func signIn(email: String, password: String) async {
        // Sign in the user and then explicitly fetch the session.
        do {
            // Perform the sign-in request.
            try await supabase.auth.signIn(
                email: email,
                password: password
            )
            
            // Retrieve the active session after a successful sign-in.
            let current = try await supabase.auth.session
            self.session = current
            self.isAuthenticated = true
        } catch {
            // Reset state on failure so UI reflects logged-out status.
            print("Sign-in failed: \(error.localizedDescription)")
            self.session = nil
            self.isAuthenticated = false
        }
    }

    func signOut() async {
        // Invalidate the session on the server and clear local state.
        do {
            try await supabase.auth.signOut()
            self.session = nil
            self.isAuthenticated = false
        } catch {
            // Sign-out errors are non-fatal to the UI; log for diagnostics.
            print("Sign-out failed: \(error.localizedDescription)")
        }
    }
}

