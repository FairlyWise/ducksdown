//
//  HomeView.swift
//  DucksDown
//
//  Created by Austin Wiseman on 2/21/25.
//

import SwiftUI

struct HomeView: View {
    @State private var blinds: [Blind] = []

    var body: some View {
        NavigationView {
            List(blinds) { blind in
                NavigationLink(destination: BlindDetailView(blind: blind)) {
                    Text(blind.name)
                }
            }
            .navigationTitle("Your Blinds")
            .toolbar {
                NavigationLink(destination: CreateBlindView()) {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            fetchBlinds()
        }
    }

    private func fetchBlinds() {
        // Firebase fetch logic
    }
}
