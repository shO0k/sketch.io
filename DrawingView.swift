//
//  DrawingView.swift
//  sketch.io
//
//  Created by John Shook on 7/23/25.
//

import SwiftUI

struct DrawingView: View {
        @Binding var image: NSImage?
        @Binding var clearTrigger: Bool
        @State private var currentDrawing = [CGPoint]()
        @State private var drawings: [[CGPoint]] = []

        var body: some View {
                ZStack {
                        Rectangle()
                                .fill(Color.white)
                                .frame(width: 400, height: 400)
                                .gesture(DragGesture(minimumDistance: 0)
                                        .onChanged { value in
                                            let location = value.location
                                                currentDrawing.append(location)
                                        }
                                        .onEnded { value in
                                            let location = value.location
                                            currentDrawing.append(location)
                                            drawings.append(currentDrawing)
                                            currentDrawing.removeAll()
                                            image = renderImage(from: drawings)
                                        }
                                )
                        //show completed strokes
                        ForEach(drawings, id: \.self) { drawing in
                                Path { path in
                                        guard let firstPoint = drawing.first else {return}
                                        path.move(to: firstPoint)
                                        for point in drawing.dropFirst() {
                                                path.addLine(to: point)
                                        }
                                }
                                .stroke(Color.black, lineWidth: 2)
                        }
                        // show current stroke in progress
                        Path { path in
                                guard let firstPoint = currentDrawing.first else {return}
                                path.move(to: firstPoint)
                                for point in currentDrawing.dropFirst() {
                                        path.addLine(to: point)
                                }
                        }
                        .stroke(Color.gray, lineWidth: 2)
                }
       		.border(Color.gray)
        	.onChange(of: clearTrigger) { _, _ in
			currentDrawing.removeAll()
            		drawings.removeAll()
            		image = nil
        	}
        }

        func renderImage(from drawings: [[CGPoint]]) -> NSImage {
                let imageSize = CGSize(width: 400, height: 400)
                let image = NSImage(size: imageSize)
                image.lockFocus()

                //white background
                let context = NSGraphicsContext.current?.cgContext
                context?.setFillColor(NSColor.white.cgColor)
                context?.fill(CGRect(origin: .zero, size: imageSize))

                 // draw path
                context?.setStrokeColor(NSColor.black.cgColor)
                context?.setLineWidth(2)

                for drawing in drawings {
                        guard let firstPoint = drawing.first else {continue}
                        context?.beginPath()
                        context?.move(to: firstPoint)
                        for point in drawing.dropFirst() {
                                context?.addLine(to: point)
                        }
                        context?.strokePath()
                }


                image.unlockFocus()
                return image
        }
}
