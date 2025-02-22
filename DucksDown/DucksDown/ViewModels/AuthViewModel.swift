//
//  AuthViewModel.swift
//  DucksDown
//
//  Created by Austin Wiseman on 2/21/25.
//

import FirebaseAuth
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated = false
    @Published var authErrorMessage: String?
    
    init() {
        checkAuthStatus()
    }

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.authErrorMessage = error.localizedDescription
                }
                return
            }
            DispatchQueue.main.async {
                self.user = User(id: result?.user.uid ?? "", name: result?.user.displayName ?? "Unknown", email: result?.user.email ?? "")
                self.isAuthenticated = true
            }
        }
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.authErrorMessage = error.localizedDescription
                }
                return
            }
            DispatchQueue.main.async {
                self.user = User(id: result?.user.uid ?? "", name: result?.user.displayName ?? "Unknown", email: result?.user.email ?? "")
                self.isAuthenticated = true
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.user = nil
                self.isAuthenticated = false
            }
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    private func checkAuthStatus() {
        if let currentUser = Auth.auth().currentUser {
            self.user = User(id: currentUser.uid, name: currentUser.displayName ?? "Unknown", email: currentUser.email ?? "")
            self.isAuthenticated = true
        }
    }
}
