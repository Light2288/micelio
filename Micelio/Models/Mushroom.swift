//
//  MushroomModel.swift
//  Micelio
//
//  Created by Davide Aliti on 10/10/23.
//

import Foundation

struct MushroomModel: Identifiable {
    let id: UUID = UUID()
    let name: String
    let image: String
    let edibility: Edibility
    let environments: [Environment]
    let seasons: [Season]
    let description: String
    let environmentDescription: String
    let edibilityDescription: String
    let trivia: String
}
