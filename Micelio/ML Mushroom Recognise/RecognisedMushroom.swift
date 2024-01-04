//
//  RecognisedMushroom.swift
//  Micelio
//
//  Created by Davide Aliti on 28/12/23.
//

import Foundation

struct RecognisedMushroom: Identifiable {
    let id: UUID
    let mushroomIdentifier: String
    let confidence: Float
    var confidencePercentage: String {
        "\((confidence * 100).roundTo(places: 2))%"
    }
}
