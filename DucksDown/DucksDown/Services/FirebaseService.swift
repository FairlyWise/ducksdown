//
//  FirebaseService.swift
//  DucksDown
//
//  Created by Austin Wiseman on 2/21/25.
//

import FirebaseAuth
import FirebaseFirestore

class FirebaseService {
    static let shared = FirebaseService()
    private let db = Firestore.firestore()
    
    // MARK: - Add Blind
    func addBlind(id: String, name: String, location: String) {
        let blindData: [String: Any] = [
            "id": id,
            "name": name,  // Ensure name is included
            "location": location
        ]

        db.collection("blinds").document(id).setData(blindData)
    }
    
    // MARK: - Sign In
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                let userModel = User(id: user.uid, name: user.displayName ?? "Unknown", email: user.email ?? "")
                completion(.success(userModel))
            }
        }
    }
    
    // MARK: - Sign Up
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                let userModel = User(id: user.uid, name: user.displayName ?? "Unknown", email: user.email ?? "")
                completion(.success(userModel))
            }
        }
    }
}
