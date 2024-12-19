//
//  SearchHeaderView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import SwiftUI

struct SearchHeaderView: View {
    @Binding var startLocationText: String
    @Binding var destinationLocationText: String

    let primaryColor: Color
    let secondaryColor: Color

    var body: some View {
        HStack(spacing: 15) {
            RouteIndicatorView(primaryColor: primaryColor, secondaryColor: secondaryColor)

            VStack {
                TextField("Pickup Location", text: $startLocationText)
                    .frame(height: 32)
                    .padding(.trailing)

                Divider()

                TextField("Where to?", text: $destinationLocationText)
                    .frame(height: 32)
                    .padding(.trailing)
            }
        }
        .padding(.leading)
        .padding(.vertical, 5)
        .background(Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 2)
                .foregroundColor(primaryColor)
        )
    }
}
