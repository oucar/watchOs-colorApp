//
//  ColorViewModel.swift
//  ColorApp Watch App
//
//  Created by Onur Ucar on 2/24/24.
//


import SwiftUI

class ColorDataProvider: ObservableObject {
    @Published var colorPalette: [[Int]] = []

    init() {
        // Fetch random color palette only if colorPalette is empty
        if colorPalette.isEmpty {
            fetchRandomColorPalette()
        }
    }

    func fetchRandomColorPalette() {
        let apiUrlString = "http://colormind.io/api/"
        let model = "default"
        let data = ["model": model]

        guard let apiUrl = URL(string: apiUrlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: data, options: [])
        } catch {
            print("Error creating JSON data: \(error)")
            return
        }

        print("Sending request to: \(apiUrlString)")
        print("Request body: \(String(data: request.httpBody ?? Data(), encoding: .utf8) ?? "Empty")")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                print("API Response: \(result)")
                DispatchQueue.main.async {
                    self.colorPalette = result.result
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

struct APIResponse: Decodable {
    let result: [[Int]]
}
