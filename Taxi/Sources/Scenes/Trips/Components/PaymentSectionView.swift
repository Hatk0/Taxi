//
//  PaymentSectionView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 20.12.2024.
//

import SwiftUI

struct PaymentSectionView: View {
    var body: some View {
        HStack(spacing: 12) {
            Text("Visa")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(6)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .foregroundStyle(.white)
                .padding(.leading)

            Text("**** 1234")
                .fontWeight(.bold)

            Spacer()

            Image(systemName: "chevron.right")
                .imageScale(.medium)
                .padding()
        }
        .frame(height: 50)
        .background(Color(.systemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
    }
}
