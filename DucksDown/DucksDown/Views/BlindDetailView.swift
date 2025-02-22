//
//  BlindDetailView.swift
//  DucksDown
//
//  Created by Austin Wiseman on 2/21/25.
//

import SwiftUI

struct BlindDetailView: View {
    var blind: Blind
    
    var body: some View {
        NavigationView {  // ✅ Wrap the whole view in NavigationView
            VStack(spacing: 16) {  // ✅ Added spacing for better UI
                
                NavigationLink(destination: AddDataView(blind: blind)) {
                    Text("Add Data")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                NavigationLink(destination: AddPhotoView(blind: blind)) {
                    Text("Add Photos")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.brown)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                NavigationLink(destination: ViewDaysView(blind: blind)) {
                    Text("View Days")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                
                Spacer() // ✅ Pushes content to the top for a better layout
            }
            .padding()
            .navigationTitle(blind.name) // ✅ Navigation title
        }
    }
}
