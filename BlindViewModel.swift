//
//  BlindViewModel.swift
//  DucksDown
//
//  Created by Austin Wiseman on 2/21/25.
//

//
//  BlindViewModel.swift
//  DucksDown
//
//  Created by Austin Wiseman on 2/21/25.
//

import FirebaseFirestore
import SwiftUI

class BlindViewModel: ObservableObject {
    @Published var blinds: [Blind] = []
    @Published var errorMessage: String?

    private let db = Firestore.firestore()

    func fetchBlinds() {
        db.collection("blinds").getDocuments { snapshot, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error fetching blinds: \(error.localizedDescription)"
                }
                return
            }

            DispatchQueue.main.async {
                self.blinds = snapshot?.documents.compactMap { doc -> Blind? in
                    let data = doc.data()
                    return Blind(
                        id: doc.documentID,
                        name: data["name"] as? String ?? "Unknown",
                        location: data["location"] as? String ?? "Unknown",  // Ensure location is needed
                        creatorId: data["creatorId"] as? String ?? "Unknown",
                        members: data["members"] as? [String] ?? []
                    )
                } ?? []
            }
        }
    }

    
    func addBlind(name: String, location: String, creatorId: String) {
        let newBlind: [String: Any] = [
            "name": name,
            "location": location,
            "creatorId": creatorId,
            "members": [creatorId],  // Default the creator as the first member
            "createdAt": Timestamp()
        ]
        
        db.collection("blinds").addDocument(data: newBlind) { error in
            if let error = error {
                print("Error adding blind: \(error.localizedDescription)")
            } else {
                self.fetchBlinds()
            }
        }
    }
}
