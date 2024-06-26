//
//  CatalogGroupBy.swift
//  Micelio
//
//  Created by Davide Aliti on 14/06/24.
//

import Foundation

enum CatalogGroupBy: String, CaseIterable, Identifiable {
    
    var id: String { return self.rawValue }
        
    var groupByTitle: String {
        return switch self {
        case .initialLetter:
            "Iniziale"
        case .edibility:
            "Edibilità"
        }
    }
    
    case initialLetter
    case edibility
}
