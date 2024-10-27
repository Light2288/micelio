//
//  MushroomMapAnnotation+Init.swift
//  Micelio
//
//  Created by Davide Aliti on 19/02/24.
//

import Foundation
import CoreData
import CoreLocation

extension MushroomMapAnnotation {
    convenience init(context: NSManagedObjectContext, location: CLLocationCoordinate2D) {
        let mushroomMapAnnotation = NSEntityDescription.entity(forEntityName: "MushroomMapAnnotation", in: context)!
        self.init(entity: mushroomMapAnnotation, insertInto: context)
        self.id = UUID()
        self.color = "accentColor"
        self.creationDate = .now
        self.latitude = location.latitude
        self.longitude = location.longitude
        self.mushroomName = "Boletus Edulis (Porcino)"
        self.notes = ""
    }
}
