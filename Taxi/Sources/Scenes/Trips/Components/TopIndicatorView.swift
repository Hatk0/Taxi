//
//  TopIndicator.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 20.12.2024.
//

import SwiftUI

struct TopIndicatorView: View {
    var body: some View {
        Capsule()
            .foregroundStyle(Color(.systemGray5))
            .frame(width: 48, height: 6)
            .padding(.top, 8)
    }
}
