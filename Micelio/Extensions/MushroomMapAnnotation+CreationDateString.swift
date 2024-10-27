//
//  MushroomMapAnnotation+CreationDateString.swift
//  Micelio
//
//  Created by Davide Aliti on 19/10/24.
//

import Foundation

extension MushroomMapAnnotation {
    var creationDateString: String {
        return DateFormatter.localizedString(from: self.creationDate ?? .now, dateStyle: .short, timeStyle: .none)
    }
}
