//
//  ContentView.swift
//  sketch.io
//
//  Created by John Shook on 7/23/25.
//
import SwiftUI

struct ContentView: View {
    @State private var sketchImage: NSImage?
    @State private var results: [String] = []
    @State private var clearTrigger = false
    
    

        var body: some View {
            VStack(spacing: 20) {
            DrawingView(image: $sketchImage, clearTrigger: $clearTrigger)
            
            HStack {
                        Button("Run Search") {
                            if let image = sketchImage {
                        let path = saveImage(image)
                         runPythonSearch(with: path)
                            }
                        }
                Button("Clear Drawing") {
                    clearTrigger.toggle()
                    results.removeAll()
                }
            }

                    List(results, id: \.self) { item in
                        Text(item)
                    }
            }
            .padding()
            .frame(width: 500, height: 600)
        }

        func saveImage(_ image: NSImage) -> String {
            let path = FileManager.default.temporaryDirectory.appendingPathComponent("sketch.png")
            if let tiffData = image.tiffRepresentation,
                   let bitmap = NSBitmapImageRep(data: tiffData),
                   let pngData = bitmap.representation(using: .png, properties: [:]) {
                    try? pngData.write(to: path)
            }
            return path.path
        }

        func runPythonSearch(with imagePath: String) {
            let process = Process()
            process.executableURL = URL(fileURLWithPath: "/usr/bin/python3")
            process.arguments = ["/Users/johnshook/Unix/Projects/Sketch/run_search.py", imagePath, "/Users/johnshook/Unix/Projects/Sketch/Test_images"]

            let pipe = Pipe()
            process.standardOutput = pipe

            do {
                    try process.run()
                    let data = pipe.fileHandleForReading.readDataToEndOfFile()
                    if let output = String(data: data, encoding: .utf8) {
                        let lines = output.split(separator: "\n").map { String($0) }
                        results = lines
                    }
            } catch {
                    print("Failed to run Python script: \(error)")
            }
    }
}
