//
//  HuntEntry.swift
//  DucksDown
//
//  Created by Austin Wiseman on 2/21/25.
//

import Foundation

struct HuntEntry: Identifiable, Codable {
    var id: String
    var userId: String
    var date: Date
    var timeOfHunt: String
    var weather: String
    var birdCount: Int
    var species: String
    var blindId: String
    var photos: [String] // URLs for images
}
