//
//  MushroomModel.swift
//  Micelio
//
//  Created by Davide Aliti on 10/10/23.
//

import Foundation

struct Mushroom: Identifiable {
    let id: UUID = UUID()
    let scientificName: String
    let commonName: String
    let veryShortDescription: String
    let shortDescription: String
    let edibility: Edibility
    let environments: [MushroomEnvironment]
    let seasons: [Season]
    let description: String
    let environmentDescription: String
    let edibilityDescription: String
    let trivia: String
    
    var images: [String] {
        (0...9).map { "\(scientificName.capitalized.filter { !$0.isWhitespace }.lowercaseFirstChar)_\($0)" }
    }
}
