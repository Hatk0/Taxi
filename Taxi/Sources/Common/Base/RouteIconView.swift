//
//  RouteIconView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import SwiftUI

struct RouteIconView<S: Shape>: View {
    let shape: S
    let size: CGFloat
    let color: Color
    let centerColor: Color

    var body: some View {
        ZStack {
            shape
                .fill(color)
                .frame(width: size, height: size)

            shape
                .fill(centerColor)
                .frame(width: size / 4, height: size / 4)
        }
    }
}
