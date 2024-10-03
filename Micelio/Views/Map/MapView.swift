//
//  MapView.swift
//  Micelio
//
//  Created by Davide Aliti on 07/02/24.
//

import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI
import CoreData

struct MapView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var manager = LocationManager()
    @State var doubleTapLocation = CGPoint.zero
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MushroomMapAnnotation.id, ascending: false)],
        animation: .default)
    private var mushroomMapAnnotations: FetchedResults<MushroomMapAnnotation>
    @Binding var addPinToMapCenterClosure: (CGSize) -> Void
    @Binding var centerOnUserPositionClosure: () -> Void
    @Binding var centerMapOnLocationClosure: (CLLocationCoordinate2D) -> Void
    @Binding var showSheet: Bool
    @Binding var selectedMushroomMapAnnotation: MushroomMapAnnotation?
    @Binding var isEditAnnotationMode: Bool
    
    var size: CGSize
    
    var body: some View {
        Map(
            coordinateRegion: $manager.region,
            showsUserLocation: true,
            annotationItems: mushroomMapAnnotations,
            annotationContent: { mushroomMapAnnotation in
                MapAnnotation(coordinate: mushroomMapAnnotation.coordinate) {
                    MushroomPinView(mushroomMapAnnotation: mushroomMapAnnotation, selectedMushroomMapAnnotation: $selectedMushroomMapAnnotation, showSheet: $showSheet, isEditAnnotationMode: $isEditAnnotationMode, centerOnPinPositionClosure: feedbackOnPinAdd, manager: manager)
                }
            }
        )
        .edgesIgnoringSafeArea([.top, .horizontal])
        .highPriorityGesture(SpatialTapGesture(count: 2, coordinateSpace: .local)
            .onEnded { event in
                doubleTapLocation = event.location
                let location = convertTapToCoordinate(at: doubleTapLocation, for: size)
                let correctedCenterLocation = CGPoint(x: doubleTapLocation.x, y: doubleTapLocation.y + size.height/4)
                let visibleCenterLocation = convertTapToCoordinate(at: correctedCenterLocation, for: size)
                setPin(at: location, centerMapAt: visibleCenterLocation)
            }
        )
        .onAppear(perform: {
            self.centerOnUserPositionClosure = centerOnUserPosition
            self.addPinToMapCenterClosure = addPinToMapCenter
            self.centerMapOnLocationClosure = animatedCenterMap(on:)
        })
    }
}

extension MapView {
    func centerOnUserPosition() {
        manager.updateLocation()
    }
}

extension MapView {
    func setPin(at location: CLLocationCoordinate2D, centerMapAt visbleCenterLocation: CLLocationCoordinate2D) -> () {
        defer {
            feedbackOnPinAdd(centerMapAt: visbleCenterLocation)
        }
        let newMushroomMapAnnotation = MushroomMapAnnotation(context: viewContext, location: location)
        selectedMushroomMapAnnotation = newMushroomMapAnnotation
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Errore non risolvibile \(nsError) \(nsError.userInfo)")
        }
    }
    
    func convertTapToCoordinate(at point: CGPoint, for mapSize: CGSize) -> CLLocationCoordinate2D {
        let lat = manager.region.center.latitude
        let lon = manager.region.center.longitude
        
        let mapCenter = CGPoint(x: mapSize.width/2, y: mapSize.height/2)
        
        let xValue = (point.x - mapCenter.x) / mapCenter.x
        let xSpan = xValue * manager.region.span.longitudeDelta/2
        
        let yValue = (point.y - mapCenter.y) / mapCenter.y
        let ySpan = yValue * manager.region.span.latitudeDelta/2
        
        return CLLocationCoordinate2D(latitude: lat - ySpan, longitude: lon + xSpan)
    }
}

extension MapView {
    func addPinToMapCenter(for mapSize: CGSize)  -> () {
        let mapCenter = CGPoint(x: mapSize.width/2, y: mapSize.height/2)
        let location = convertTapToCoordinate(at: mapCenter, for: mapSize)
        let visibleMapCenter = CGPoint(x: mapSize.width/2, y: mapSize.height*3/4)
        let visibleMapLocation = convertTapToCoordinate(at: visibleMapCenter, for: mapSize)
        setPin(at: location, centerMapAt: visibleMapLocation)
    }
}

extension MapView {
    func feedbackOnPinAdd(centerMapAt location: CLLocationCoordinate2D, isEditAnnotationMode: Bool = true) {
        self.isEditAnnotationMode = isEditAnnotationMode
        showSheet = true
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        animatedCenterMap(on: location)
    }
}

extension MapView {
    func animatedCenterMap(on location: CLLocationCoordinate2D) {
        withAnimation {
            manager.region = MKCoordinateRegion(center: location, span: manager.region.span)
        }
    }
}

#Preview {
    func centerOnUserPosition() { }
    
    func addPinToMapCenter(size: CGSize) -> () {
        return
    }
    
    func animatedCenterMap(on: CLLocationCoordinate2D) -> () {
        return
    }
    
    return GeometryReader { proxy in
        MapView(addPinToMapCenterClosure: .constant(addPinToMapCenter), centerOnUserPositionClosure: .constant(centerOnUserPosition), centerMapOnLocationClosure: .constant(animatedCenterMap(on:)), showSheet: .constant(false), selectedMushroomMapAnnotation: .constant(nil), isEditAnnotationMode: .constant(false), size: proxy.size)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
