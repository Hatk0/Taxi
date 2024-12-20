//
//  MapViewActionButton.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import SwiftUI

struct MapViewActionButton: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    @Binding var mapState: MapViewState

    private var theme: ColorTheme {
        ColorManager.getTheme(for: colorScheme)
    }

    var body: some View {
        Button {
            withAnimation(.spring) {
                actionForState(mapState)
            }
        } label: {
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
        Image(systemName: imageNameForState(mapState))
            .font(.title2)
            .foregroundStyle(theme.primary)
    }

    func actionForState(_ state: MapViewState) {
        switch state {
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected:
            mapState = .noInput
            locationSearchViewModel.selectedLocation = nil
        default:
            break
        }
    }

    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput:
            return "line.3.horizontal"
        default:
            return "arrow.left"
        }
    }
}
