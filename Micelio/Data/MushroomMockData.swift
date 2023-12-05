//
//  MushroomData.swift
//  Micelio
//
//  Created by Davide Aliti on 11/10/23.
//

import Foundation

var mushroomMockData: [Mushroom] {
    var data: [Mushroom] = []
    var porcino = generateMockMushroom(mushroomName: "porcino")
    data.append(porcino)
    data.append(contentsOf: generateMockMushroomArray(length: 20))
    
    return data
}
