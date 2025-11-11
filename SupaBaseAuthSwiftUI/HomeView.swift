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

struct HomeView: View {
    @ObservedObject var authViewModel: AuthViewModel
    var body: some View {
        Text("WELCOME HOME")
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
