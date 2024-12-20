//
//  LocationSearchViewModel.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {

    @Published var results: [MKLocalSearchCompletion] = []
    @Published var selectedLocation: Location?
    @Published var pickupTime: String?
    @Published var dropOffTime: String?

    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    var userLocation: CLLocationCoordinate2D?

    private let searchCompleter = MKLocalSearchCompleter()

    override init() {
        super.init()

        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }

    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("Error during location search: \(error.localizedDescription)")
                return
            }

            guard let item = response?.mapItems.first else {
                print("No map items found for the given search query.")
                return
            }

            let coordinate = item.placemark.coordinate
            self.selectedLocation = Location(title: localSearch.title, coordinate: coordinate)
        }
    }

    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)

        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }

    func computeRidePrice(for type: RideType) -> Double {
        guard let destinationCoordinate = selectedLocation?.coordinate else { return 0 }
        guard let userLocation = self.userLocation else { return 0 }

        let userCoordinate = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let destination = CLLocation(latitude: destinationCoordinate.latitude, longitude: destinationCoordinate.longitude)
        let tripDistanceInMeters = userCoordinate.distance(from: destination)

        return type.computePrice(distance: tripDistanceInMeters)
    }

    func getDestinationRoute(
        from userLocation: CLLocationCoordinate2D,
        to destination: CLLocationCoordinate2D,
        completion: @escaping (MKRoute) -> Void
    ) {
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print("Failed to get destinations with error: \(error.localizedDescription)")
                return
            }

            guard let route = response?.routes.first else { return }
            self.configurePickupAndDropoffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }

    func configurePickupAndDropoffTimes(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"

        pickupTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date().addingTimeInterval(expectedTravelTime))
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
