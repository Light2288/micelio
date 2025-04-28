//
//  LocationManager.swift
//  Micelio
//
//  Created by Davide Aliti on 31/01/24.
//

import MapKit

final class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion()
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var shouldCenterOnUser: Bool = true
    
    var lastKnownLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        
#if DEBUG
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            // We are running inside a Preview!
            self.userLocation = CLLocationCoordinate2D(latitude: 45.4642, longitude: 9.19)
        }
#endif
        
        self.setup()
    }
    
    func setup() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            locationManager.requestLocation()
        case .notDetermined:
            locationManager.startUpdatingLocation()
            locationManager.requestAlwaysAuthorization()
        default:
            break
        }
    }
    
    func updateLocation() {
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {
            print("No last location")
            return
        }
        
        self.lastKnownLocation = lastLocation.coordinate
        
        DispatchQueue.main.async {
            self.userLocation = lastLocation.coordinate
            
            if self.shouldCenterOnUser {
                self.region = MKCoordinateRegion(
                    center: lastLocation.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
                
                self.shouldCenterOnUser = false
            }
        }
    }
    
    func recenterOnUser() {
        if let lastLocation = lastKnownLocation {
            self.region = MKCoordinateRegion(
                center: lastLocation,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            self.shouldCenterOnUser = false
        } else {
            self.updateLocation()
            self.shouldCenterOnUser = false
        }
    }
}


extension LocationManager {
    
    func startMonitoring(annotation: MushroomMapAnnotation, radius: CLLocationDistance) {
        let annotationCoordinate = CLLocationCoordinate2D(latitude: annotation.latitude, longitude: annotation.longitude)
        let identifier = "\(annotation.id?.uuidString ?? "")_\(annotation.mushroomName ?? "")_\(annotation.creationDateString)"
        let region = CLCircularRegion(center: annotationCoordinate, radius: radius, identifier: identifier)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        locationManager.startMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered region")
        if region is CLCircularRegion {
            print("Region is a CLCircularRegion")
            handleRegionEvent(for: region)
        }
    }
    
    private func parseRegionIdentifier(for region: CLRegion) -> [String] {
        return region.identifier.components(separatedBy: "_")
    }
    
    private func handleRegionEvent(for region: CLRegion) {
        let parsedIdentifier = parseRegionIdentifier(for: region)
        let id = parsedIdentifier[0]
        let mushroomName = parsedIdentifier[1]
        let creationDate = parsedIdentifier[2]
        let body: String = "Sei nelle vicinanze di una delle tue posizioni contrassegnate, dove il giorno \(creationDate) hai trovato un \(mushroomName)!"
        
        NotificationManager.shared.scheduleNotification(id: UUID(uuidString: id) ?? UUID(), title: "Sei vicino a uno dei tuoi segnaposto!", body: body)
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Monitoring failed for region: \(String(describing: region)) with error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Started monitoring for region: \(region.identifier)")
    }
}

