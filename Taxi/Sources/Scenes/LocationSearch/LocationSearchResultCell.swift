//
//  LocationSearchResultCell.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import SwiftUI

struct LocationSearchResultCell: View {
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundStyle(Color.blue)
                .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text("Random")
                    .font(.body)

                Text("99, Yeset Batyr Street, Aktobe")
                    .font(.system(size: 15))
                    .foregroundStyle(Color.gray)

                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
        .padding(.leading)
    }
}

#Preview {
    LocationSearchResultCell()
}
