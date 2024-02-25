//
//  ColorView.swift
//  ColorApp Watch App
//
//  Created by Onur Ucar on 2/25/24.
//

import Foundation
import SwiftUI

struct ColorView: View {
    let rgb: [Int]

    var body: some View {
        Color(red: Double(rgb[0]) / 255.0, green: Double(rgb[1]) / 255.0, blue: Double(rgb[2]) / 255.0)
            .frame(height: 48.5)
            .frame(width: .infinity)
            .overlay(
                Text(rgb.hexString)
                    .foregroundColor(.white)
                    .font(.caption)
                    .padding(0)
            )
    }
}

extension Array where Element == Int {
    var hexString: String {
        let r = String(format: "%02X", self[0])
        let g = String(format: "%02X", self[1])
        let b = String(format: "%02X", self[2])
        return "#\(r)\(g)\(b)"
    }
}
