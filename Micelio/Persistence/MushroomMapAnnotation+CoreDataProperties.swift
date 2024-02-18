//
//  MushroomMapAnnotation+CoreDataProperties.swift
//  Micelio
//
//  Created by Davide Aliti on 15/02/24.
//
//

import Foundation
import CoreData


extension MushroomMapAnnotation {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MushroomMapAnnotation> {
        return NSFetchRequest<MushroomMapAnnotation>(entityName: "MushroomMapAnnotation")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var color: String?
    @NSManaged public var mushroomName: String?
    @NSManaged public var notes: String?
    
}

extension MushroomMapAnnotation : Identifiable {
    
}
