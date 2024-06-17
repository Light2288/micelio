//
//  Edibility.swift
//  Micelio
//
//  Created by Davide Aliti on 10/10/23.
//

import Foundation

enum Edibility: String, CaseIterable, Identifiable {
    
    var id: String { return self.rawValue }
    
    var edibilityTitle: String {
        switch self {
        case .edible:
            "Commestibile"
        case .edibleAfterCooking:
            "Commestibile dopo cottura"
        case .edibleWithoutAlcohol:
            "Commestibile senza alcolici"
        case .noValue:
            "Nessun valore"
        case .poisonous:
            "Velenoso"
        case .deadly:
            "Velenoso mortale"
        }
    }
    
    case edible
    case edibleAfterCooking
    case edibleWithoutAlcohol
    case noValue
    case poisonous
    case deadly
}
