//
//  MushroomMapAnnotationPhoto+CoreDataProperties.swift
//  Micelio
//
//  Created by Davide Aliti on 11/09/24.
//
//

import Foundation
import CoreData


extension MushroomMapAnnotationPhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MushroomMapAnnotationPhoto> {
        return NSFetchRequest<MushroomMapAnnotationPhoto>(entityName: "MushroomMapAnnotationPhoto")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var photo: Data?
    @NSManaged public var creationDate: Date?
    @NSManaged public var mushroomMapAnnotation: MushroomMapAnnotation?

}

extension MushroomMapAnnotationPhoto : Identifiable {

}
