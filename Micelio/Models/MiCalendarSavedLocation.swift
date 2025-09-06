//
//  MiCalendarSavedLocation.swift
//  Micelio
//
//  Created by Davide Aliti on 10/06/25.
//

import Foundation

struct MiCalendarSavedLocation: Codable, Hashable {
    let name: String
    let shortName: String
    let latitude: Double
    let longitude: Double
}

extension MiCalendarSavedLocation {
    static func == (lhs: MiCalendarSavedLocation, rhs: MiCalendarSavedLocation) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
