//
//  Mushroom+AnnotationMushroomName.swift
//  Micelio
//
//  Created by Davide Aliti on 22/02/24.
//

import Foundation

extension Mushroom {
    var annotationMushroomName: String {
        "\(self.scientificName.capitalized) (\(self.commonName.capitalized))"
    }
}
