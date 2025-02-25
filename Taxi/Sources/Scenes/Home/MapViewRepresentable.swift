//
//  MapViewRepresentable.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    @Binding var mapState: MapViewState

    let mapView = MKMapView()
    let locationManager = LocationManager.shared

    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        return mapView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch mapState {
        case .idle:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            break
        case .searching:
            break
        case .locationConfirmed:
            if let coordinate = locationSearchViewModel.selectedLocation?.coordinate {
                context.coordinator.addAndSelectedAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        case .routePlotted:
            break
        }
    }

    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension MapViewRepresentable {

    class MapCoordinator: NSObject, MKMapViewDelegate {

        let parent: MapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?

        init(parent: MapViewRepresentable) {
            self.parent = parent
            super.init()
        }

        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate

            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude
                ),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )

            self.currentRegion = region

            parent.mapView.setRegion(region, animated: true)
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            let overlay = MKPolylineRenderer(overlay: overlay)
            overlay.strokeColor = .systemBlue
            overlay.lineWidth = 6
            return overlay
        }

        func addAndSelectedAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            parent.mapView.addAnnotation(annotation)
            parent.mapView.selectAnnotation(annotation, animated: true)
        }

        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }

            parent.locationSearchViewModel.getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                self.parent.mapState = .routePlotted
                let rect = self.parent.mapView.mapRectThatFits(
                    route.polyline.boundingMapRect,
                    edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32)
                )
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }

        func clearMapViewAndRecenterOnUserLocation() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)

            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}
