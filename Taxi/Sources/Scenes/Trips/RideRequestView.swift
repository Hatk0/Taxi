//
//  RideRequestView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 20.12.2024.
//

import SwiftUI

struct RideRequestView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    @State private var selectedRideType: RideType = .economy

    private var theme: ColorTheme {
        ColorManager.getTheme(for: colorScheme)
    }

    var body: some View {
        VStack {
            TopIndicatorView()

            RideLocationSectionView(
                pickupTime: locationSearchViewModel.pickupTime,
                dropOffTime: locationSearchViewModel.dropOffTime,
                selectedLocation: locationSearchViewModel.selectedLocation,
                theme: theme
            )

            Divider()

            RideSuggestionsView(
                selectedRideType: $selectedRideType,
                viewModel: locationSearchViewModel
            )

            Divider()
                .padding(.vertical, 8)

            PaymentSectionView()

            ConfirmRideButtonView()
        }
        .padding(.bottom, 24)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
