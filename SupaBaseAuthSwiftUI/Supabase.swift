//
    // Project: SupaBaseAuthSwiftUI
    //  File: Supabase.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger

// MARK: - Supabase Client Configuration

import Supabase
import Foundation

/// Global Supabase client used throughout the app. Replace with your project URL and anon/public key.
let supabase = SupabaseClient(supabaseURL: URL(string: "YOUR PROJECT URL")!, supabaseKey: "YOUR API KEY")

