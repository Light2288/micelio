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
    
    func startMonitoring(annotationCoordinate: CLLocationCoordinate2D, radius: CLLocationDistance) {
        print("Start monitoring")
        let region = CLCircularRegion(center: annotationCoordinate, radius: radius, identifier: UUID().uuidString)
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
    
    private func handleRegionEvent(for region: CLRegion) {
        NotificationManager.shared.scheduleNotification(title: "You're near your annotation!", body: "You entered the area of your marked location.")
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Monitoring failed for region: \(String(describing: region)) with error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Started monitoring for region: \(region.identifier)")
    }
}

