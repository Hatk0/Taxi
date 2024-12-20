//
//  LocationSearchView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import SwiftUI

struct LocationSearchView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    @State private var startLocationText = ""
    @State private var destinationLocationText = ""
    @Binding var showLocationSearchView: Bool

    private var theme: ColorTheme {
        ColorManager.getTheme(for: colorScheme)
    }

    var body: some View {
        VStack {
            SearchHeaderView(
                locationSearchViewModel: locationSearchViewModel,
                startLocationText: $startLocationText,
                primaryColor: theme.primary,
                secondaryColor: theme.secondary
            )
            .padding(.horizontal)
            .padding(.top, 64)

            Divider()
                .padding(.vertical)

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(locationSearchViewModel.results, id: \.self) { result in
                        LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                withAnimation(.spring) {
                                    locationSearchViewModel.selectLocation(result.title)
                                    showLocationSearchView.toggle()
                                }
                            }
                    }
                }
            }
        }
        .background(Color(.systemBackground))
    }
}
