//
//  ConfirmRideButtonView.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 20.12.2024.
//

import SwiftUI

struct ConfirmRideButtonView: View {
    var body: some View {
        Button {
            // Action for confirming the ride
        } label: {
            Text("CONFIRM RIDE")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.white)
                .padding(.horizontal)
        }
    }
}
