//
//  RideLocationSectionView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 20.12.2024.
//

import SwiftUI

struct RideLocationSectionView: View {
    let pickupTime: String?
    let dropOffTime: String?
    let selectedLocation: Location?
    let theme: ColorTheme

    var body: some View {
        HStack {
            RouteIndicatorView(primaryColor: theme.primary, secondaryColor: theme.secondary)

            VStack(alignment: .leading, spacing: 24) {
                LocationRowView(
                    title: "Current Location",
                    time: pickupTime,
                    textColor: Color(.darkGray)
                )
                .padding(.bottom, 10)

                if let location = selectedLocation {
                    LocationRowView(
                        title: location.title,
                        time: dropOffTime
                    )
                }
            }
            .padding(.leading, 8)
        }
        .padding()
    }
}
