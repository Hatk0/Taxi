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
    @State private var mapState = MapViewState.noInput

    var body: some View {
        ZStack(alignment: .top) {
            MapViewRepresentable(mapState: $mapState)
                .ignoresSafeArea()

            if mapState == .searchingForLocation {
                LocationSearchView(mapState: $mapState)
            } else if mapState == .noInput {
                LocationSearchActivationView()
                    .padding(.vertical, 72)
                    .onTapGesture {
                        withAnimation(.spring) {
                            mapState = .searchingForLocation
                        }
                    }
            }

            MapViewActionButton(mapState: $mapState)
                .padding(.leading)
                .padding(.top, 4)
        }
    }
}
