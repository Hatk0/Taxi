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

    @Published var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }

    private let searchCompleter = MKLocalSearchCompleter()

    override init() {
        super.init()

        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
