//
//  NSImage + Extension.swift
//  HoleFilling-Light
//
//  Created by Yankel Melloul on 26/06/2022.
//

import Foundation
import AppKit

extension NSImage {
    func toGrayScaleMatrix() -> MatrixGrayPixel? {
        let bitmap = cgImage(forProposedRect: nil, context: nil, hints: nil)
        guard let data = bitmap?.dataProvider?.data, var pointer = CFDataGetBytePtr(data) else {return nil}
        var matrix = MatrixGrayPixel(value: [[GrayPixel]]())
        let row = Int(self.size.height)
        let column = Int(self.size.width)
        
        for _ in 0..<row {
            var pixels = [GrayPixel]()
            for _ in 0..<column {
                let r = pointer.pointee
                pointer = pointer.advanced(by: 1)
                
                let g = pointer.pointee
                pointer = pointer.advanced(by: 1)
                
                let b = pointer.pointee
                pointer = pointer.advanced(by: 1)
                
                let a = pointer.pointee
                pointer = pointer.advanced(by: 1)
                
                pixels.append(GrayPixel(pixel: Pixel(r: r, g: g, b: b, a: a)))
            }
            matrix.value.append(pixels)
        }
        
        return matrix
    }
    
    func save(path: String) {
        guard let tiffRepresentation = self.tiffRepresentation else {
            print("tiffRepresentation - Error")
            return
        }
        
        let fileURL = URL(fileURLWithPath: path)
        let fileType = NSBitmapImageRep.FileType.jpeg
        
        try? NSBitmapImageRep(data: tiffRepresentation)?
            .representation(using: fileType, properties: [:])?
            .write(to: fileURL)
    }
    
}
