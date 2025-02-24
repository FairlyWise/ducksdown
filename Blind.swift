//
//  Blind.swift
//  DucksDown
//
//  Created by Austin Wiseman on 2/21/25.
//

import Foundation

struct Blind: Identifiable, Codable {
    var id: String
    var name: String
    var location: String
    var creatorId: String
    var members: [String]
}
