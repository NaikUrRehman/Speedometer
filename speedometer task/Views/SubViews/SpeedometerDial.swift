//
//  SpeedometerDial.swift
//  speedometer task
//
//  Created by Naik Ur Rehman on 02/08/2025.
//

import SwiftUI

struct SpeedometerDial: View {
    let value: Double
    let angle: Double
    let labelPoints: [(value: Double, angle: Double)]

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let dialSize = size * 0.9

            ZStack {
                dialBackground
                    .frame(width: dialSize, height: dialSize)

                dialProgress(size: dialSize)

                dialLabels(size: dialSize)

                centerCap(size: dialSize * 0.18)

                needle(size: dialSize * 0.3)

                valueDisplay(offsetY: dialSize * 0.22)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }

    private var dialBackground: some View {
        ZStack {
            Image("radialCircle")
                .resizable()
                .scaledToFit()
            Image("innerEllipse")
                .resizable()
                .scaledToFit()
                .padding(10)
        }
    }

    private func dialProgress(size: CGFloat) -> some View {
        Circle()
            .trim(from: 0, to: progress(for: value))
            .stroke(AppColors.lightBlue, style: StrokeStyle(lineWidth: size * 0.03, lineCap: .round))
            .frame(width: size * 0.96, height: size * 0.96)
            .rotationEffect(.degrees(150))
            .animation(.easeInOut(duration: 0.4), value: value)
    }

    private func dialLabels(size: CGFloat) -> some View {
        ForEach(labelPoints, id: \.value) { point in
            VStack {
                Text(point.value >= 100_000 ? "100k+" : cleanLabel(point.value))
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(-point.angle))
                Spacer()
            }
            .rotationEffect(.degrees(point.angle))
            .frame(width: size * 0.88, height: size * 0.88)
            .padding(.trailing, 10)
        }
    }

    private func centerCap(size: CGFloat) -> some View {
        Circle()
            .fill(Color.black)
            .frame(width: size, height: size)
            .shadow(radius: 2)
    }

    private func needle(size: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: size * 0.1)
            .fill(AppColors.lightBlue)
            .frame(width: 5, height: size)
            .offset(y: -size * 0.6)
            .rotationEffect(.degrees(angle))
            .animation(.easeInOut(duration: 0.5), value: angle)
    }

    private func valueDisplay(offsetY: CGFloat) -> some View {
        Text(cleanLabel(value))
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(AppColors.lightBlue)
            .offset(y: offsetY)
    }

    private func progress(for val: Double) -> Double {
        let clamped = min(val, 100_000)
        for i in 0..<(labelPoints.count - 1) {
            let current = labelPoints[i]
            let next = labelPoints[i + 1]
            if (current.value...next.value).contains(clamped) {
                let t = (clamped - current.value) / (next.value - current.value)
                let interpolatedAngle = current.angle + t * (next.angle - current.angle)
                return max(0, min((interpolatedAngle + 120) / 360, 1))
            }
        }
        return 1
    }
    
    private func cleanLabel(_ val: Double) -> String {
        if val >= 100_000 {
            return "100k+"
        } else if val >= 1_000 {
            let k = val / 1_000
            return k == floor(k) ? "\(Int(k))k" : String(format: "%.1fk", k)
        } else {
            return "\(Int(val))"
        }
    }
}
