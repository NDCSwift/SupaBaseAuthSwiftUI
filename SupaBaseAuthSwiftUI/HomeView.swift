//
    // Project: SupaBaseAuthSwiftUI
    //  File: HomeView.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    

import SwiftUI

/// Post-authentication screen shown when a user is signed in.
struct HomeView: View {
    /// Access to auth actions for signing out from the home screen.
    @ObservedObject var authViewModel: AuthViewModel
    var body: some View {
        // Example content for the authenticated area.
        Text("WELCOME HOME")
        // Allow the user to sign out and clear their session.
        Button("sign-out"){
            Task {
                await authViewModel.signOut()
            }
        }
    }
}
//
//#Preview {
//    HomeView()
//}
