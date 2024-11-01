//
//  RecognisedMushroom.swift
//  Micelio
//
//  Created by Davide Aliti on 28/12/23.
//

import Foundation

struct RecognisedMushroom: Identifiable {
    let id: UUID = UUID()
    let mushroomIdentifier: String
    let confidence: Float
    
    var confidencePercentage: String {
        "\((confidence * 100).roundTo(places: 2))%"
    }
    
    var mushroomDetail: Mushroom {
        mushroomData.first { $0.scientificName.compare(self.mushroomIdentifier, options: [.caseInsensitive, .diacriticInsensitive]) == .orderedSame }!
    }
}
