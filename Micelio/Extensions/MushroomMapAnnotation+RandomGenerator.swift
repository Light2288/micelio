//
//  MushroomMapAnnotation+RandomGenerator.swift
//  Micelio
//
//  Created by Davide Aliti on 15/02/24.
//

import Foundation
import CoreData

extension MushroomMapAnnotation {
    
    class func generateRandom(context: NSManagedObjectContext) {
        let mushroomMapAnnotation = NSEntityDescription.insertNewObject(forEntityName: "MushroomMapAnnotation", into: context) as? MushroomMapAnnotation
        mushroomMapAnnotation?.color = MushroomMapAnnotation.colors.randomElement()?.key
        mushroomMapAnnotation?.latitude = Double.random(in: 45.49080961927744 ..< 45.498734555774)
        mushroomMapAnnotation?.longitude = Double.random(in: 9.261367818615799 ..< 9.276388268523824)
        mushroomMapAnnotation?.mushroomName = ["Boletus Edulis (Porcino)", "Amanita Muscaria (Ovolo Malefico)"].randomElement()
        mushroomMapAnnotation?.notes = "test note"
    }
}
