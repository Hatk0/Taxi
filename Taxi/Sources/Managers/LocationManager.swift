//
//  LocationManager.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        
        locationManager.stopUpdatingLocation()
    }
}
