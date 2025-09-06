//
//  LocationManager.swift
//  Micelio
//
//  Created by Davide Aliti on 31/01/24.
//

import MapKit
import Combine

final class LocationManager: NSObject, ObservableObject {
    static let shared = LocationManager()

    private let locationManager = CLLocationManager()

    @Published var region = MKCoordinateRegion()
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var shouldCenterOnUser: Bool = true

    var lastKnownLocation: CLLocationCoordinate2D?

    private var locationCancellable: AnyCancellable?

    private override init() {
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false

#if DEBUG
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            print("Running inside preview!")
            self.userLocation = CLLocationCoordinate2D(latitude: 45.4642, longitude: 9.19)
        }
#endif

        observeUserLocation()
        setup()
    }

    /// Sets up permissions and starts location updates.
    func setup() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            locationManager.requestLocation()
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        default:
            break
        }
    }

    func updateLocation() {
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
    }

    /// Recenter the region to user location, with fallback retry logic.
    func recenterOnUser() {
        if let location = userLocation {
            region = MKCoordinateRegion(
                center: location,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            shouldCenterOnUser = false
        } else {
            shouldCenterOnUser = true
            updateLocation()
        }
    }

    /// Starts Combine observation of userLocation to reactively center on it.
    private func observeUserLocation() {
        locationCancellable = $userLocation
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newLocation in
                guard let self = self else { return }

//                print("🔄 userLocation updated to: \(newLocation)")

                if self.shouldCenterOnUser {
                    self.region = MKCoordinateRegion(
                        center: newLocation,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                    self.shouldCenterOnUser = false
                }
            }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            manager.requestLocation()
        case .denied, .restricted:
            userLocation = nil
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("📍 Location error: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {
            print("⚠️ No last location received")
            return
        }

//        print("✅ Received updated location: \(lastLocation.coordinate)")

        lastKnownLocation = lastLocation.coordinate

        DispatchQueue.main.async {
            self.userLocation = lastLocation.coordinate
        }
    }
}

// MARK: - Geofencing Support
extension LocationManager {
    func startMonitoring(annotation: MushroomMapAnnotation, radius: CLLocationDistance) {
        let coordinate = CLLocationCoordinate2D(latitude: annotation.latitude, longitude: annotation.longitude)
        let identifier = "\(annotation.id?.uuidString ?? "")_\(annotation.mushroomName ?? "")_\(annotation.creationDateString)"
        let region = CLCircularRegion(center: coordinate, radius: radius, identifier: identifier)
        region.notifyOnEntry = true
        region.notifyOnExit = false

        locationManager.startMonitoring(for: region)
    }

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard region is CLCircularRegion else { return }
        handleRegionEvent(for: region)
    }

    private func parseRegionIdentifier(for region: CLRegion) -> [String] {
        region.identifier.components(separatedBy: "_")
    }

    private func handleRegionEvent(for region: CLRegion) {
        let components = parseRegionIdentifier(for: region)
        guard components.count == 3 else { return }

        let id = components[0]
        let mushroomName = components[1]
        let creationDate = components[2]

        let body = "Sei nelle vicinanze di una delle tue posizioni contrassegnate, dove il giorno \(creationDate) hai trovato un \(mushroomName)!"
        NotificationManager.shared.scheduleNotification(
            id: UUID(uuidString: id) ?? UUID(),
            title: "Sei vicino a uno dei tuoi segnaposto!",
            body: body
        )
    }

    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("❌ Monitoring failed for region: \(String(describing: region)) with error: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("📍 Started monitoring for region: \(region.identifier)")
    }
}
