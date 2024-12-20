//
//  RouteIndicatorView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import SwiftUI

struct RouteIndicatorView: View {
    let primaryColor: Color
    let secondaryColor: Color

    var body: some View {
        VStack(spacing: 2) {
            RouteIconView(
                shape: Circle(),
                size: 15,
                color: primaryColor,
                centerColor: secondaryColor
            )

            Rectangle()
                .fill(primaryColor)
                .frame(width: 2, height: 32)

            RouteIconView(
                shape: Rectangle(),
                size: 15,
                color: primaryColor,
                centerColor: secondaryColor
            )
        }
    }
}

