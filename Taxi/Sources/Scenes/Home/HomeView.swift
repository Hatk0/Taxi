//
//  ContentView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    @State private var mapState = MapViewState.idle

    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                MapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()

                if mapState == .searching {
                    LocationSearchView(mapState: $mapState)
                } else if mapState == .idle {
                    LocationSearchActivationView()
                        .padding(.vertical, 72)
                        .onTapGesture {
                            withAnimation(.spring) {
                                mapState = .searching
                            }
                        }
                }

                MapViewActionButton(mapState: $mapState)
                    .padding(.leading)
                    .padding(.top, 4)
            }

            if mapState == .locationConfirmed || mapState == .routePlotted {
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
                locationSearchViewModel.userLocation = location
            }
        }
    }
}
