//
//  Mushroom+ImageURLs.swift
//  Micelio
//
//  Created by Davide Aliti on 02/01/25.
//

import Foundation

import Foundation

extension Mushroom {
    var imageURLs: [URL] {
        images.compactMap { imageName in
            Bundle.main.url(forResource: imageName, withExtension: "jpeg")
        }
    }
}
