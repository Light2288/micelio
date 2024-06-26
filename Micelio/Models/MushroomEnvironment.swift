//
//  MushroomEnvironment.swift
//  Micelio
//
//  Created by Davide Aliti on 10/10/23.
//

import Foundation

enum MushroomEnvironment: String, CaseIterable, Identifiable {
    
    var id: String { return self.rawValue }
    
    case broadLeavedForest = "Foreste di latifoglie"
    case coniferousForest = "Foreste di conifere"
    case field = "Prati"
    case lignicolous = "Lignicolo"

}
