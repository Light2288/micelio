//
//  MushroomMapAnnotation+CoreDataProperties.swift
//  Micelio
//
//  Created by Davide Aliti on 05/09/24.
//
//

import Foundation
import CoreData


extension MushroomMapAnnotation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MushroomMapAnnotation> {
        return NSFetchRequest<MushroomMapAnnotation>(entityName: "MushroomMapAnnotation")
    }

    @NSManaged public var color: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var mushroomName: String?
    @NSManaged public var notes: String?
    @NSManaged public var mushroomMapAnnotationPhotos: Set<MushroomMapAnnotationPhoto>?

}

// MARK: Generated accessors for mushroomMapAnnotationPhotos
extension MushroomMapAnnotation {

    @objc(addMushroomMapAnnotationPhotosObject:)
    @NSManaged public func addToMushroomMapAnnotationPhotos(_ value: MushroomMapAnnotationPhoto)

    @objc(removeMushroomMapAnnotationPhotosObject:)
    @NSManaged public func removeFromMushroomMapAnnotationPhotos(_ value: MushroomMapAnnotationPhoto)

    @objc(addMushroomMapAnnotationPhotos:)
    @NSManaged public func addToMushroomMapAnnotationPhotos(_ values: Set<MushroomMapAnnotationPhoto>)

    @objc(removeMushroomMapAnnotationPhotos:)
    @NSManaged public func removeFromMushroomMapAnnotationPhotos(_ values: Set<MushroomMapAnnotationPhoto>)

}

extension MushroomMapAnnotation : Identifiable {

}
