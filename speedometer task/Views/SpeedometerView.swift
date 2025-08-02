//
//  ContentView.swift
//  speedometer task
//
//  Created by Naik Ur Rehman on 02/08/2025.
//

import SwiftUI

struct SpeedometerView: View {
    @State private var value: Double = 14000
    @State private var angle: Double = -120
    @State private var inputValue: String = ""
    @State private var error: String?

    private let labelPoints: [(value: Double, angle: Double)] = [
        (0, -120), (1_000, -80), (5_000, -40),
        (10_000, 0), (25_000, 40), (50_000, 80), (100_000, 120)
    ]

    var body: some View {
        VStack(spacing: 40) {
            Text("Welcome to the Speedometer Task!")
                .font(.title2)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()

            SpeedometerDial(value: value, angle: angle, labelPoints: labelPoints)
                .frame(height: 350)

            SpeedometerInput(inputValue: $inputValue, onSet: handleSet, error: error)
        }
        .padding()
        .onAppear {
            angle = angleForValue(value)
        }
    }

    private func handleSet() {
        guard let newValue = Double(inputValue.trimmingCharacters(in: .whitespaces)), newValue >= 0 else {
            error = "Please enter a valid non-negative number"
            return
        }

        let clamped = min(newValue, 150_000)
        value = clamped
        angle = angleForValue(clamped)
        error = nil

        // Haptic feedback
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }

    private func angleForValue(_ val: Double) -> Double {
        let clamped = min(val, 100_000)
        for i in 0..<(labelPoints.count - 1) {
            let current = labelPoints[i]
            let next = labelPoints[i + 1]
            if (current.value...next.value).contains(clamped) {
                let progress = (clamped - current.value) / (next.value - current.value)
                return current.angle + progress * (next.angle - current.angle)
            }
        }
        return labelPoints.last?.angle ?? -120
    }
}



// MARK: - Preview
#Preview {
    SpeedometerView()
}
