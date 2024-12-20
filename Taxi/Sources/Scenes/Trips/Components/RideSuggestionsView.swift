//
//  RideSuggestionsView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 20.12.2024.
//

import SwiftUI

struct RideSuggestionsView: View {
    @Binding var selectedRideType: RideType
    @ObservedObject var viewModel: LocationSearchViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(RideType.allCases) { type in
                        RideOptionCardView(
                            type: type,
                            price: viewModel.computeRidePrice(for: type).toCurrency(),
                            isSelected: type == selectedRideType
                        )
                        .onTapGesture {
                            withAnimation(.spring) {
                                selectedRideType = type
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
