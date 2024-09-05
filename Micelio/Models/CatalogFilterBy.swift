//
//  CatalogFilterBy.swift
//  Micelio
//
//  Created by Davide Aliti on 25/06/24.
//

import Foundation

struct CatalogFilterBy {
    var edibilityFilters: [Edibility] = []
    var environmentFilters: [MushroomEnvironment] = []
    var seasonFilters: [Season] = []
    
    var noFiltersSet: Bool {
        return edibilityFilters.isEmpty && environmentFilters.isEmpty && seasonFilters.isEmpty
    }
}
