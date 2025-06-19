//
//  MiCalendarSavedLocation.swift
//  Micelio
//
//  Created by Davide Aliti on 10/06/25.
//

import Foundation

struct MiCalendarSavedLocation: Codable, Hashable {
    let name: String
    let latitude: Double
    let longitude: Double
}
