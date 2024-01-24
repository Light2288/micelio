//
//  MushroomData.swift
//  Micelio
//
//  Created by Davide Aliti on 11/10/23.
//

import Foundation

var mushroomMockData: [Mushroom] {
    var data: [Mushroom] = []
    let porcino = generateMockMushroom(mushroomScientificName: "boletus edulis", mushroomCommonName: "porcino")
    data.append(porcino)
    let porcino2 = generateMockMushroom(mushroomScientificName: "boletus edulis", mushroomCommonName: "porcino")
    data.append(porcino2)
    let amanita = generateMockMushroom(mushroomScientificName: "amanita muscaria", mushroomCommonName: "ovolo malefico")
    data.append(amanita)
    data.append(contentsOf: generateMockMushroomArray(length: 20))
    
    return data
}
