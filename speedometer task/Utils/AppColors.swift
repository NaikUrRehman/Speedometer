//
//  AppColors.swift
//  speedometer task
//
//  Created by Naik Ur Rehman on 02/08/2025.
//

import SwiftUI

struct AppColors {
    static let lightBlue = Color(r: 84, g: 159, b: 205)
}



extension Color {
    init(r: Int, g: Int, b: Int) {
        self.init(
            .sRGB,
            red: Double(r) / 255.0,
            green: Double(g) / 255.0,
            blue: Double(b) / 255.0,
            opacity: 1.0
        )
    }
}
