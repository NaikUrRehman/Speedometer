//
//  SpeedometerInput.swift
//  speedometer task
//
//  Created by Naik Ur Rehman on 02/08/2025.
//

import SwiftUI

struct SpeedometerInput: View {
    @Binding var inputValue: String
    let onSet: () -> Void
    let error: String?

    var body: some View {
        VStack(spacing: 10) {
            TextField("Enter value", text: $inputValue)
                .keyboardType(.numberPad)
                .padding()
                .frame(width: 200, height: 50)
                .background(Color(.systemGray6))
                .cornerRadius(8)

            Text(error ?? " ")
                .font(.caption)
                .foregroundColor(.red)
                .frame(height: 16)
                .animation(.easeInOut(duration: 0.2), value: error)

            Button("SET", action: onSet)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(AppColors.lightBlue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
