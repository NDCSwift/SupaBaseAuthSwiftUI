# 🔐 Supabase Auth — SwiftUI

A SwiftUI app demonstrating how to integrate Supabase Authentication into an iOS app — including sign up, sign in, and session management.

---

## 🤔 What this is

This project shows how to connect Supabase to a SwiftUI app for user authentication. It covers setting up the Supabase Swift SDK, configuring your project URL and API key, and building sign-up/login flows backed by `AuthViewModel`. After authentication, users land on a `HomeView` that reflects their session state.

## ✅ Why you'd use it

- **Supabase Swift SDK** — minimal setup to add auth without rolling your own backend
- **`AuthViewModel`** — handles sign up, sign in, sign out, and `onAuthStateChange` session listening
- **`LoginView` + `HomeView`** — complete auth flow with navigation between unauthenticated and authenticated states
- **`Supabase.swift` config file** — shows exactly where to drop in your project URL and anon key
- **Alternative to Firebase** — same pattern as Firebase Auth but with a Postgres-backed open source backend

## 📺 Watch on YouTube

[![Watch on YouTube](https://img.shields.io/badge/YouTube-Watch%20the%20Tutorial-red?style=for-the-badge&logo=youtube)](https://youtu.be/cPRBc_ecr84)

> This project was built for the [NoahDoesCoding YouTube channel](https://www.youtube.com/@NoahDoesCoding97).

---

## 🚀 Getting Started

### 1. Clone the Repo
```bash
git clone https://github.com/NDCSwift/SupaBaseAuthSwiftUI.git
cd SupaBaseAuthSwiftUI
```

### 2. Add Your Supabase Credentials
> ⚠️ **REQUIRED:** Open `Supabase.swift` and replace the placeholder URL and API key with your own.  
> Find these in your Supabase dashboard → Settings → API.

### 3. Add the Supabase Swift Package
In Xcode → File → Add Package Dependencies:
```
https://github.com/supabase/supabase-swift
```

### 4. Open in Xcode
Double-click `SupaBaseAuthSwiftUI.xcodeproj`.

### 5. Set Your Development Team
TARGET → Signing & Capabilities → Team

### 6. Update the Bundle Identifier
Change `com.example.MyApp` to a unique identifier.

---

## 🛠️ Notes
- Supabase credentials are NOT included — provide your own from [supabase.com](https://supabase.com).
- Enable Email auth in your Supabase project dashboard → Authentication → Providers.

## 📦 Requirements
- Xcode 16+
- iOS 17+
- Supabase account + project

📺 [Watch the guide on YouTube](https://youtu.be/cPRBc_ecr84)
