//
//  ContentView.swift
//  ColorApp Watch App
//
//  Created by Onur Ucar on 2/24/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var colorViewModel = ColorViewModel()

    var body: some View {
        VStack {
            HStack {
                ForEach(colorViewModel.colorPalette.prefix(3), id: \.self) { color in
                    Color(hex: color.hexString) // Assuming you have a Color extension to convert RGB to Color
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                        .overlay(
                            Text(color.hexString)
                                .foregroundColor(.white)
                                .font(.caption)
                                .padding(4)
                        )
                }
            }

            Button("Get Random Colors") {
                colorViewModel.fetchRandomColorPalette()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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

struct ColorViewModel: ObservableObject {
    @Published var colorPalette: [[Int]] = []

    func fetchRandomColorPalette() {
        // ... (rest of the code remains the same)
    }
}
