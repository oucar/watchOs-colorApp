import SwiftUI
import WatchKit

struct ContentView: View {
    @StateObject private var colorViewModel = ColorViewModel()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
                .onTapGesture(count: 2) {
                    colorViewModel.fetchRandomColorPalette()
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
                }
                .disabled(true)
            }
            .onTapGesture(count: 2) {
                colorViewModel.fetchRandomColorPalette()
            }
            // Ignore safe area insets
            .ignoresSafeArea()
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
