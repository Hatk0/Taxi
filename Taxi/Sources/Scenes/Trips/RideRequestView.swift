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
    @State private var selectedRideType: RideType = .uberX

    private var theme: ColorTheme {
        ColorManager.getTheme(for: colorScheme)
    }

    var body: some View {
        VStack {
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)

            HStack {
                RouteIndicatorView(primaryColor: theme.primary, secondaryColor: theme.secondary)

                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("Current Location")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color(.darkGray))

                        Spacer()

                        Text(locationSearchViewModel.pickupTime ?? "")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.gray)
                    }
                    .padding(.bottom, 10)

                    HStack {
                        if let location = locationSearchViewModel.selectedLocation {
                            Text(location.title)
                                .font(.system(size: 16, weight: .semibold))
                        }

                        Spacer()

                        Text(locationSearchViewModel.dropOffTime ?? "")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.leading, 8)
            }
            .padding()

            Divider()

            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(RideType.allCases) { type in
                        VStack(alignment: .leading) {
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()

                            VStack(alignment: .leading, spacing: 4) {
                                Text(type.description)
                                    .font(.system(size: 14, weight: .semibold))

                                Text(locationSearchViewModel.computeRidePrice(for: type).toCurrency())
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding()
                        }
                        .frame(width: 112, height: 140)
                        .foregroundStyle(type == selectedRideType ? .white : .black)
                        .background(Color(type == selectedRideType ? .systemBlue : .systemGroupedBackground))
                        .scaleEffect(type == selectedRideType ? 1.2 : 1)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            withAnimation(.spring) {
                                selectedRideType = type
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)

            Divider()
                .padding(.vertical, 8)

            HStack(spacing: 12) {
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .foregroundStyle(.white)
                    .padding(.leading)

                Text("**** 1234")
                    .fontWeight(.bold)

                Spacer()

                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(Color(.systemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)

            Button {

            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(Color.white)
            }
        }
        .padding(.bottom, 24)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
