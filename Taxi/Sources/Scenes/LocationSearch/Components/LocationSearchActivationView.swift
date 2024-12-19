//
//  LocationSearchActivationView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import SwiftUI

struct LocationSearchActivationView: View {
    @Environment(\.colorScheme) var colorScheme

    private var textColor: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    private var backgroundColor: Color {
        colorScheme == .dark ? Color.white : Color.black
    }

    var body: some View {
        HStack {
            Rectangle()
                .fill(backgroundColor)
                .frame(width: 8, height: 8)
                .padding(.horizontal)

            Text("Where to?")
                .foregroundColor(textColor)

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
