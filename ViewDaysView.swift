//
//  ViewDaysView.swift
//  DucksDown
//
//  Created by Austin Wiseman on 2/21/25.
//

import SwiftUI
import FirebaseFirestore

struct ViewDaysView: View {
    var blindID: String
    @State private var huntDays: [HuntEntry] = []

    var body: some View {
        List(huntDays) { hunt in
            VStack(alignment: .leading) {
                Text("\(hunt.date)")
                    .font(.headline)
                Text("Time: \(hunt.timeOfHunt)")
                Text("Weather: \(hunt.weather)")
                Text("Bird Count: \(hunt.birdCount)")
                Text("Species: \(hunt.species)")
            }
            .padding()
        }
        .onAppear(perform: fetchHuntDays)
        .navigationTitle("Hunt Logs")
    }

    private func fetchHuntDays() {
        let db = Firestore.firestore()
        db.collection("blinds").document(blindID).collection("hunts")
            .order(by: "date", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching hunts: \(error.localizedDescription)")
                    return
                }
                if let snapshot = snapshot {
                    huntDays = snapshot.documents.compactMap { doc -> HuntEntry? in
                        let data = doc.data()
                        return HuntEntry(
                            id: doc.documentID,
                            date: data["date"] as? String ?? "",
                            timeOfHunt: data["timeOfHunt"] as? String ?? "",
                            weather: data["weather"] as? String ?? "",
                            birdCount: data["birdCount"] as? Int ?? 0,
                            species: data["species"] as? String ?? ""
                        )
                    }
                }
            }
    }
}
