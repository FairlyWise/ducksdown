//
//  User.swift
//  DucksDown
//
//  Created by Austin Wiseman on 2/21/25.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var name: String
    var email: String
}
