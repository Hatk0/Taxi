//
//  LocationRowView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 20.12.2024.
//

import SwiftUI

struct LocationRowView: View {
    let title: String
    let time: String?
    var textColor: Color = .primary

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(textColor)

            Spacer()

            if let time = time {
                Text(time)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.gray)
            }
        }
    }
}
