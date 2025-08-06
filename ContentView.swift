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
                                Button("Search") {
                                        if let image = sketchImage {
                                                let savedPath = saveImage(image)
                                                runPythonSearch(with: savedPath)
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
                let directoryPath = "/Users/johnshook/Unix/Projects/Sketch/sketch.io/sketch.io/Images"
                let filename = "sketch_\(Int(Date().timeIntervalSince1970)).png"
                let path = URL(fileURLWithPath: directoryPath).appendingPathComponent(filename)
                if let tiffData = image.tiffRepresentation,
                        let bitmap = NSBitmapImageRep(data: tiffData),
                        let pngData = bitmap.representation(using: .png, properties: [:]) {
                        try? pngData.write(to: path)
                }
            return path.path
        }

        func runPythonSearch(with sketchPath: String) {
                let startPath = "/Users/johnshook/Unix/Projects/Sketch/Test_images"
                let output = Initializer.runSearchScript(sketchPath: sketchPath, startPath: startPath)
                let lines = output.split(separator: "\n").map {String($0)}
                results = lines
        }
}
