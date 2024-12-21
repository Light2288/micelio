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
    @ObservedObject var locationManager: LocationManager
    
    let geofencingDistance: CLLocationDistance = Constants.MushroomMap.geofencingDistance
    
    var body: some View {
        Map(
            coordinateRegion: $locationManager.region,
            showsUserLocation: true,
            annotationItems: mushroomMapAnnotations,
            annotationContent: { mushroomMapAnnotation in
                MapAnnotation(coordinate: mushroomMapAnnotation.coordinate) {
                    MushroomPinView(mushroomMapAnnotation: mushroomMapAnnotation, selectedMushroomMapAnnotation: $selectedMushroomMapAnnotation, showSheet: $showSheet, isEditAnnotationMode: $isEditAnnotationMode, centerOnPinPositionClosure: feedbackOnPinAdd, manager: locationManager)
                }
            }
        )
        .edgesIgnoringSafeArea([.top, .horizontal])
        .highPriorityGesture(SpatialTapGesture(count: 2, coordinateSpace: .local)
            .onEnded { event in
                doubleTapLocation = event.location
                handleDoubleTapGesture(at: doubleTapLocation, mapSize: size)
            }
        )
        .onAppear(perform: {
            NotificationManager.shared.requestNotificationPermission()
            self.centerOnUserPositionClosure = centerOnUserPosition
            self.addPinToMapCenterClosure = addPinToMapCenter
            self.centerMapOnLocationClosure = animatedCenterMap(on:)
        })
    }
}

extension MapView {
    func centerOnUserPosition() {
        locationManager.shouldCenterOnUser = true
        locationManager.recenterOnUser()
    }
}

extension MapView {
    func setPin(at location: CLLocationCoordinate2D, centerMapAt visbleCenterLocation: CLLocationCoordinate2D) -> () {
        let newMushroomMapAnnotation = MushroomMapAnnotation(context: viewContext, location: location)
        selectedMushroomMapAnnotation = newMushroomMapAnnotation
        defer {
            feedbackOnPinAdd(centerMapAt: visbleCenterLocation)
            let radius: CLLocationDistance = geofencingDistance
            locationManager.startMonitoring(annotation: newMushroomMapAnnotation, radius: radius)
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Errore non risolvibile \(nsError) \(nsError.userInfo)")
        }
    }
    
    func convertTapToCoordinate(at point: CGPoint, for mapSize: CGSize) -> CLLocationCoordinate2D {
        let lat = locationManager.region.center.latitude
        let lon = locationManager.region.center.longitude
        
        let mapCenter = CGPoint(x: mapSize.width/2, y: mapSize.height/2)
        
        let xValue = (point.x - mapCenter.x) / mapCenter.x
        let xSpan = xValue * locationManager.region.span.longitudeDelta/2
        
        let yValue = (point.y - mapCenter.y) / mapCenter.y
        let ySpan = yValue * locationManager.region.span.latitudeDelta/2
        
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
            locationManager.region = MKCoordinateRegion(center: location, span: locationManager.region.span)
        }
    }
}

extension MapView {
    func handleDoubleTapGesture(at location: CGPoint, mapSize: CGSize) {
        let tapCoordinate = convertTapToCoordinate(at: location, for: mapSize)
        print("tapCoordinate: \(tapCoordinate)")
        let correctedCenterLocation = CGPoint(x: location.x, y: location.y + mapSize.height / 4)
        let visibleCenterCoordinate = convertTapToCoordinate(at: correctedCenterLocation, for: mapSize)
        setPin(at: tapCoordinate, centerMapAt: visibleCenterCoordinate)
    }
}

#Preview {
    let centerOnUserPosition = { }
    
    let addPinToMapCenter: (CGSize) -> () = { _ in }
    
    let animatedCenterMap: (CLLocationCoordinate2D) -> () = { _ in }
    
    GeometryReader { proxy in
        MapView(addPinToMapCenterClosure: .constant(addPinToMapCenter), centerOnUserPositionClosure: .constant(centerOnUserPosition), centerMapOnLocationClosure: .constant(animatedCenterMap), showSheet: .constant(false), selectedMushroomMapAnnotation: .constant(nil), isEditAnnotationMode: .constant(false), size: proxy.size, locationManager: LocationManager())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
