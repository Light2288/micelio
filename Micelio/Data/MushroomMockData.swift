//
//  MushroomData.swift
//  Micelio
//
//  Created by Davide Aliti on 11/10/23.
//

import Foundation

var mushroomMockData: [Mushroom] {
    var data: [Mushroom] = []
    let porcino = generateMockMushroom(mushroomName: "porcino")
    data.append(porcino)
    let porcino2 = generateMockMushroom(mushroomName: "porcino")
    data.append(porcino2)
    data.append(contentsOf: generateMockMushroomArray(length: 20))
    
    return data
}
