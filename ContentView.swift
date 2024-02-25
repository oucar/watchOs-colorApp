//
//  ContentView.swift
//  ColorApp Watch App
//
//  Created by Onur Ucar on 2/24/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var colorViewModel = ColorDataProvider()
    @State private var opacity: Double = 1.0

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
                .onTapGesture(count: 2) {
                    handleTapGesture()
                }

            ColorScrollView(colorViewModel: colorViewModel, opacity: $opacity)
        }
        .onChange(of: colorViewModel.colorPalette) {
            withAnimation(.easeInOut(duration: 0.3)) {
                opacity = 1.0
            }
        }
    }

    private func handleTapGesture() {
        withAnimation(.easeInOut(duration: 0.3)) {
            colorViewModel.fetchRandomColorPalette()
            opacity = 0.01
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorScrollView: View {
    @ObservedObject var colorViewModel: ColorDataProvider
    @Binding var opacity: Double

    var body: some View {
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
            handleTapGesture()
        }
        .ignoresSafeArea()
    }

    private func handleTapGesture() {
        withAnimation(.easeInOut(duration: 0.3)) {
            colorViewModel.fetchRandomColorPalette()
            opacity = 0.01
        }
    }
}
