//
//  LocationSearchActivationView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import SwiftUI

struct LocationSearchActivationView: View {
    @Environment(\.colorScheme) var colorScheme

    private var theme: ColorTheme {
        ColorManager.getTheme(for: colorScheme)
    }

    var body: some View {
        HStack {
            Rectangle()
                .fill(theme.primary)
                .frame(width: 8, height: 8)
                .padding(.horizontal)

            Text("Where to?")
                .foregroundColor(theme.primary)

            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
            Rectangle()
                .fill(Color(.systemBackground))
        )
    }
}
