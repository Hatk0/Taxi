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
            MapViewRepresentable()
                .ignoresSafeArea()

            if showLocationSearchView {
                LocationSearchView(showLocationSearchView: $showLocationSearchView)
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
