//
    // Project: SupaBaseAuthSwiftUI
    //  File: ContentView.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    

import SwiftUI

/// Root view that switches between authenticated and unauthenticated flows.
struct ContentView: View {
    /// Hold a single source of truth for auth state across the view hierarchy.
    @StateObject private var authViewModel = AuthViewModel()
    var body: some View {
        // Decide which screen to show based on authentication status.
        Group{
            if authViewModel.isAuthenticated {
                HomeView(authViewModel: authViewModel)
            } else {
                LoginView(authViewModel: authViewModel)
            }
        }
        // On appearance, attempt to restore the previous session.
        .task{
            await authViewModel.getInitialSession()
        }
    }
}

//#Preview {
//    ContentView()
//}

