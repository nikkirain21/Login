//
//  ContentView.swift
//  Login
//
//  Created by Nikki Rain Tolentino on 9/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var isLoading = false
    @State private var loginFailed = false

    var body: some View {
        NavigationView {
            if isLoggedIn {
                WelcomeView(onLogout: {
                    isLoggedIn = false
                    username = ""
                    password = ""
                })
            } else {
                VStack(spacing: 30) {
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    if loginFailed {
                        Text("Login failed. Try again.")
                            .foregroundColor(.red)
                    }

                    if isLoading {
                        ProgressView()
                    } else {
                        Button("Login") {
                            login()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }

                }
                .padding()
                .navigationTitle("Login")
            }
        }
    }

    func login() {
        isLoading = true
        loginFailed = false

        // Simulate API call with delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            if username == "user" && password == "pass" {
                isLoggedIn = true
            } else {
                loginFailed = true
            }
        }
    }
}

struct WelcomeView: View {
    var onLogout: () -> Void

    var body: some View {
        VStack(spacing: 30) {
            Text("Welcome!")
                .font(.largeTitle)
                .padding()

            Button("Logout") {
                onLogout()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

#Preview {
    ContentView()
}
