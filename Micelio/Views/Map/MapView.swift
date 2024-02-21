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
    @State var longPressLocation = CGPoint.zero
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MushroomMapAnnotation.id, ascending: false)],
        animation: .default)
    private var mushroomMapAnnotations: FetchedResults<MushroomMapAnnotation>
    @Binding var addPinToMapCenterClosure: (CGSize) -> Void
    @Binding var centerOnUserPositionClosure: () -> Void
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
                    MushroomPinView(mushroomMapAnnotation: mushroomMapAnnotation, selectedMushroomMapAnnotation: $selectedMushroomMapAnnotation, showSheet: $showSheet, isEditAnnotationMode: $isEditAnnotationMode)
                }
            }
        )
        .edgesIgnoringSafeArea([.top, .horizontal])
        .gesture(
            LongPressGesture(minimumDuration: Constants.MushroomMap.Map.longPressMinimumDuration)
                .sequenced(before: DragGesture(
                    minimumDistance: .zero,
                    coordinateSpace: .local))
                .onEnded { value in
                    switch value {
                    case .second(true, let drag):
                        longPressLocation = drag?.location ?? .zero
                        let location = convertTapToCoordinate(at: longPressLocation, for: size)
                        setPin(at: location)
                    default:
                        break
                    }
                })
        .highPriorityGesture(DragGesture(minimumDistance: Constants.MushroomMap.Map.dragGestureMinimumDistance))
        .onAppear(perform: {
            self.centerOnUserPositionClosure = centerOnUserPosition
            self.addPinToMapCenterClosure = addPinToMapCenter
        })
    }
}

extension MapView {
    func centerOnUserPosition() {
        manager.updateLocation()
    }
}

extension MapView {
    func setPin(at location: CLLocationCoordinate2D) -> () {
        defer {
            feedbackOnPinAdd(at: location)
        }
        let newMushroomMapAnnotation = MushroomMapAnnotation(context: viewContext, location: location)
        selectedMushroomMapAnnotation = newMushroomMapAnnotation
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("error.coredata.saving \(nsError) \(nsError.userInfo)")
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
        setPin(at: location)
    }
}

extension MapView {
    func feedbackOnPinAdd(at location: CLLocationCoordinate2D) {
        showSheet = true
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        manager.region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
}

#Preview {
    func centerOnUserPosition() { }
    
    func addPinToMapCenter(size: CGSize) -> () {
        return
    }
    
    return GeometryReader { proxy in
        MapView(addPinToMapCenterClosure: .constant(addPinToMapCenter), centerOnUserPositionClosure: .constant(centerOnUserPosition), showSheet: .constant(false), selectedMushroomMapAnnotation: .constant(nil), isEditAnnotationMode: .constant(false), size: proxy.size)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
