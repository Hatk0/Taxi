//
//  RideType.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 20.12.2024.
//

enum RideType: Int, CaseIterable, Identifiable {
    case uberX
    case black
    case uberXL

    var id: Int { rawValue }

    var description: String {
        switch self {
        case .uberX: return "UberX"
        case .black: return "UberBlack"
        case .uberXL: return "UberXL"
        }
    }

    var imageName: String {
        switch self {
        case .uberX, .uberXL: return "uber-x"
        case .black: return "uber-black"
        }
    }

    var baseFare: Double {
        switch self {
        case .uberX: return 5
        case .black: return 20
        case .uberXL: return 10
        }
    }

    func computePrice(distance: Double) -> Double {
        let distanceInMiles = distance / 1600

        switch self {
        case .uberX: return distanceInMiles * 1.5 + baseFare
        case .black: return distanceInMiles * 2 + baseFare
        case .uberXL: return distanceInMiles * 1.75 + baseFare
        }
    }
}
