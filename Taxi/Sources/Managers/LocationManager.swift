//
//  LocationManager.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import MapKit

class LocationManager: NSObject, ObservableObject {

    @Published var userLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus?

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()

    override init() {
        super.init()

        Task {
            await requestLocationAccess()
        }
    }

    @MainActor
    func requestLocationAccess() async {
        let status = locationManager.authorizationStatus
        self.authorizationStatus = status

        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            startUpdatingLocation()
        case .denied, .restricted:
            print("Location access denied or restricted.")
        @unknown default:
            print("Unknown location access status.")
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            startUpdatingLocation()
        }
    }
}

private extension LocationManager {

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
}
