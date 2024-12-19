//
//  MapViewActionButton.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import SwiftUI

struct MapViewActionButton: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var showLocationSearchingView: Bool

    private var theme: ColorTheme {
        ColorManager.getTheme(for: colorScheme)
    }

    var body: some View {
        Button(action: toggleView) {
            buttonContent
                .padding()
                .background(theme.secondary)
                .clipShape(Circle())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private extension MapViewActionButton {
    var buttonContent: some View {
        Image(systemName: showLocationSearchingView ? "arrow.left" : "line.3.horizontal")
            .font(.title2)
            .foregroundStyle(theme.primary)
    }

    func toggleView() {
        withAnimation(.spring) {
            showLocationSearchingView.toggle()
        }
    }
}
