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
    @State private var showLocationSearchView = false
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: .constant(
                MKCoordinateRegion(
                    center: locationManager.userLocation?.coordinate ?? CLLocationCoordinate2D(),
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            ), showsUserLocation: true)
            .ignoresSafeArea()

            if showLocationSearchView {
                LocationSearchView()
            } else {
                LocationSearchActivationView()
                    .padding(.vertical, 72)
                    .onTapGesture {
                        withAnimation(.spring) {
                            showLocationSearchView.toggle()
                        }
                    }
            }

            MapViewActionButton(showLocationSearchingView: $showLocationSearchView)
                .padding(.leading)
                .padding(.top, 4)
        }
    }
}

#Preview {
    HomeView()
}
