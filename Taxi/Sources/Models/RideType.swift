//
//  RideType.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 20.12.2024.
//

enum RideType: Int, CaseIterable, Identifiable {
    case economy
    case premium
    case large

    var id: Int { rawValue }

    var description: String {
        switch self {
        case .economy: return "Economy"
        case .premium: return "Business"
        case .large: return "Comfort"
        }
    }

    var imageName: String {
        switch self {
        case .economy, .large: return "economylarge"
        case .premium: return "premium"
        }
    }

    var baseFare: Double {
        switch self {
        case .economy: return 5
        case .premium: return 20
        case .large: return 10
        }
    }

    func computePrice(distance: Double) -> Double {
        let distanceInMiles = distance / 1600

        switch self {
        case .economy: return distanceInMiles * 1.5 + baseFare
        case .premium: return distanceInMiles * 2 + baseFare
        case .large: return distanceInMiles * 1.75 + baseFare
        }
    }
}
