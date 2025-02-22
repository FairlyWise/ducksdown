//
//  CreateBlindView.swift
//  DucksDown
//
//  Created by Austin Wiseman on 2/21/25.
//

import SwiftUI
import FirebaseFirestore

struct CreateBlindView: View {
    @State private var blindName = ""
    @State private var location = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Create a New Blind")
                .font(.largeTitle)
                .bold()
                .padding()

            TextField("Blind Name", text: $blindName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Location", text: $location)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Create Blind") {
                createBlind()
            }
            .disabled(blindName.isEmpty || location.isEmpty)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            Spacer()
        }
        .padding()
    }

    private func createBlind() {
        let db = Firestore.firestore()
        let newBlind = ["name": blindName, "location": location, "createdAt": Timestamp()] as [String : Any]
        
        db.collection("blinds").addDocument(data: newBlind) { error in
            if let error = error {
                print("Error adding blind: \(error.localizedDescription)")
            } else {
                dismiss()
            }
        }
    }
}
