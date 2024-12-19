//
//  LocationSearchView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import SwiftUI

struct LocationSearchView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var startLocationText = ""
    @State private var destinationLocationText = ""

    private var theme: ColorTheme {
        ColorManager.getTheme(for: colorScheme)
    }

    var body: some View {
        VStack {
            SearchHeaderView(
                startLocationText: $startLocationText,
                destinationLocationText: $destinationLocationText,
                primaryColor: theme.primary,
                secondaryColor: theme.secondary
            )
            .padding(.horizontal)
            .padding(.top, 64)

            Divider()
                .padding(.vertical)

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(1..<5, id: \.self) { _ in
                        LocationSearchResultCell()
                    }
                }
            }
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    LocationSearchView()
}
