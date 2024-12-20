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
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?

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

    func selectLocation(_ location: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: location) { response, error in
            if let error = error {
                print("Error during location search: \(error.localizedDescription)")
                return
            }

            guard let item = response?.mapItems.first else {
                print("No map items found for the given search query.")
                return
            }

            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
        }
    }

    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)

        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }

    func computeRidePrice(for type: RideType) -> Double {
        guard let destinationCoordinate = selectedLocationCoordinate else { return 0 }
        guard let userLocation = self.userLocation else { return 0 }

        let userCoordinate = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let destination = CLLocation(latitude: destinationCoordinate.latitude, longitude: destinationCoordinate.longitude)
        let tripDistanceInMeters = userCoordinate.distance(from: destination)

        return type.computePrice(distance: tripDistanceInMeters)
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
