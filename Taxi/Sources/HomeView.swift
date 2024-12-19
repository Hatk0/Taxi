//
//  ContentView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        Map(coordinateRegion: .constant(
            MKCoordinateRegion(
                center: locationManager.userLocation?.coordinate ?? CLLocationCoordinate2D(),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        ), showsUserLocation: true)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    HomeView()
}
