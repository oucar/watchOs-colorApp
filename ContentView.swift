import SwiftUI

struct ContentView: View {
    @StateObject private var colorViewModel = ColorViewModel()
    @State private var opacity: Double = 1.0

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
                .onTapGesture(count: 2) {
                    withAnimation {
                        colorViewModel.fetchRandomColorPalette()
                        // Set a low opacity for fade-in effect
                        opacity = 0.01
                    }
                }

            VStack {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(colorViewModel.colorPalette, id: \.self) { color in
                            ColorView(rgb: color)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .offset(y: 0)
                    .opacity(opacity)
                }
                .disabled(true)
            }
            .onTapGesture(count: 2) {
                withAnimation {
                    colorViewModel.fetchRandomColorPalette()
                    // Set a low opacity for fade-in effect
                    opacity = 0.01
                }
            }
            .ignoresSafeArea()
        }
        .onChange(of: colorViewModel.colorPalette) { newColorPalette, _ in
            withAnimation {
                // Reset opacity for the fade-out effect
                opacity = 1.0
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
