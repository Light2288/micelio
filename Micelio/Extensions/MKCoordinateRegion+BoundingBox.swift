//
//  MKCoordinateRegion+BoundingBox.swift
//  Micelio
//
//  Created by Davide Aliti on 17/06/25.
//

import Foundation
import MapKit

class BoundingBox: NSObject {
    let min: CLLocationCoordinate2D
    let max: CLLocationCoordinate2D
    
    init(mapRect: MKMapRect) {
        let bottomLeft = MKMapPoint(x: mapRect.origin.x, y: mapRect.origin.y)
        let topRight = MKMapPoint(x: mapRect.maxX, y: mapRect.maxY)
        
        self.min = bottomLeft.coordinate
        self.max = topRight.coordinate
        super.init()
    }
    
    init(displayRegion: GeographicRegion) {
        let coordinateArray = displayRegion.rawValue.components(separatedBy: ",").map{Double($0)!}
        min = CLLocationCoordinate2D(latitude: coordinateArray[3], longitude: coordinateArray[2])
        max = CLLocationCoordinate2D(latitude: coordinateArray[1], longitude: coordinateArray[0])
        super.init()
    }
}

enum GeographicRegion: String {
    case italy = "6.4249344739,36.5251754248,18.6001470417,47.2242034152"
}

class RegionUtility: NSObject {
    
    static public func region(for region: GeographicRegion) -> MKCoordinateRegion {
        return MKCoordinateRegion(coordinates: bboxCoordinates(from: region.rawValue))!
    }
    
    static private func bboxCoordinates(from coordinateString: String) -> [CLLocationCoordinate2D] {
        var coordinateArray: [CLLocationCoordinate2D] = []
        let boundingBoxArray: [Double] = coordinateString.components(separatedBy: ",").map{Double($0)!}
        
        let max = CLLocationCoordinate2D(latitude: boundingBoxArray[1], longitude: boundingBoxArray[0])
        let min = CLLocationCoordinate2D(latitude: boundingBoxArray[3], longitude: boundingBoxArray[2])
        coordinateArray = [min, max]
        
        return coordinateArray
    }
}

extension MKCoordinateRegion {
    
    // From: https://gist.github.com/dionc/46f7e7ee9db7dbd7bddec56bd5418ca6
    init?(coordinates: [CLLocationCoordinate2D]) {
        
        // first create a region centered around the prime meridian
        let primeRegion = MKCoordinateRegion.region(for: coordinates, transform: { $0 }, inverseTransform: { $0 })
        
        // next create a region centered around the 180th meridian
        let transformedRegion = MKCoordinateRegion.region(for: coordinates, transform: MKCoordinateRegion.transform, inverseTransform: MKCoordinateRegion.inverseTransform)
        
        // return the region that has the smallest longitude delta
        if let a = primeRegion,
           let b = transformedRegion,
           let min = [a, b].min(by: { $0.span.longitudeDelta < $1.span.longitudeDelta }) {
            self = min
        }
        
        else if let a = primeRegion {
            self = a
        }
        
        else if let b = transformedRegion {
            self = b
        }
        
        else {
            return nil
        }
    }
    
    // Latitude -180...180 -> 0...360
    private static func transform(c: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        if c.longitude < 0 { return CLLocationCoordinate2DMake(c.latitude, 360 + c.longitude) }
        return c
    }
    
    // Latitude 0...360 -> -180...180
    private static func inverseTransform(c: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        if c.longitude > 180 { return CLLocationCoordinate2DMake(c.latitude, -360 + c.longitude) }
        return c
    }
    
    private typealias Transform = (CLLocationCoordinate2D) -> (CLLocationCoordinate2D)
    
    private static func region(for coordinates: [CLLocationCoordinate2D], transform: Transform, inverseTransform: Transform) -> MKCoordinateRegion? {
        
        // handle empty array
        guard !coordinates.isEmpty else { return nil }
        
        // handle single coordinate
        guard coordinates.count > 1 else {
            return MKCoordinateRegion(center: coordinates[0], span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        }
        
        let transformed = coordinates.map(transform)
        
        // find the span
        let minLat = transformed.min { $0.latitude < $1.latitude }!.latitude
        let maxLat = transformed.max { $0.latitude < $1.latitude }!.latitude
        let minLon = transformed.min { $0.longitude < $1.longitude }!.longitude
        let maxLon = transformed.max { $0.longitude < $1.longitude }!.longitude
        let span = MKCoordinateSpan(latitudeDelta: maxLat - minLat, longitudeDelta: maxLon - minLon)
        
        // find the center of the span
        let center = inverseTransform(CLLocationCoordinate2DMake((maxLat - span.latitudeDelta / 2), maxLon - span.longitudeDelta / 2))
        
        return MKCoordinateRegion(center: center, span: span)
    }
}
