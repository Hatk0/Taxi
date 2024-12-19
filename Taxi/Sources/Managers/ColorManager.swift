//
//  ColorThemeManager.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 19.12.2024.
//

import SwiftUI

struct ColorTheme {
    let primary: Color
    let secondary: Color
}

struct ColorManager {
    static func getTheme(for colorScheme: ColorScheme) -> ColorTheme {
        ColorTheme(
            primary: colorScheme == .dark ? .white : .black,
            secondary: colorScheme == .dark ? .black : .white
        )
    }
}
