//
//  RideOptionCardView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 20.12.2024.
//

import SwiftUI

struct RideOptionCardView: View {
    let type: RideType
    let price: String
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Image(type.imageName)
                .resizable()
                .scaledToFit()

            VStack(alignment: .leading, spacing: 4) {
                Text(type.description)
                    .font(.system(size: 14, weight: .semibold))

                Text(price)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding()
        }
        .frame(width: 112, height: 140)
        .foregroundStyle(isSelected ? .white : .black)
        .background(isSelected ? Color.blue : Color(.systemGroupedBackground))
        .scaleEffect(isSelected ? 1.2 : 1)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
