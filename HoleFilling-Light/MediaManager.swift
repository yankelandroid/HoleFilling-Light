//
//  MediaManager.swift
//  HoleFilling-Light
//
//  Created by Yankel Melloul on 27/06/2022.
//

import Foundation
import AppKit

extension Float {
    func toUInt8() -> UInt8 {
        if !self.isInfinite && !self.isNaN {
            return UInt8(self)
        } else {
            return 0
        }
    }
}

class MediaManager {
    
    
    func isInBoundary(_ coordinate: PixelCoordinate, rows: Int, columns: Int) -> Bool {
        return coordinate.x >= 0 && coordinate.x < rows && coordinate.y >= 0 && coordinate.y < columns
    }
    
    /// Algorithm to filled the hole into the picture given
    /// ⚠️ Assuming that the source image and the mask have the same size
    ///
    /// - Parameters:
    ///   - sourceGrayscale: Source image with a grayScale matrix [[Float]]
    ///   - maskGrayScale: Mask image with a grayScale matrix [[Float]]
    ///   - zeta: Float for the default weight function
    ///   - espilon: Float for the default weight function
    ///   - pixelConnectivity: 4 or 8
    func filledHole(sourceGrayscale: inout MatrixGrayPixel,
                    maskGrayScale: MatrixGrayPixel,
                    zeta: Float,
                    espilon: Float,
                    pixelConnectivity: PixelConnectivityType) {
        
        var holeBody = Set<PixelCoordinate>()
        var boundary = Set<PixelCoordinate>()
        
        let rows = sourceGrayscale.rows
        let columns = sourceGrayscale.columns
        
        var addToBorder = [[Bool]]()
        for _ in 0..<rows {
            var row = [Bool]()
            for _ in 0..<columns {
                row.append(false)
            }
            addToBorder.append(row)
        }
        
        for i in 0..<rows {
            for j in 0..<columns {
                let currentPixel = PixelCoordinate(x: i, y: j)
                if isInBoundary(currentPixel, rows: rows, columns: columns) {
                    let holePixel = maskGrayScale.value[currentPixel.x][currentPixel.y]
                    if holePixel.isHole() {
                        holeBody.insert(currentPixel)
                        let pixelsAround = getPixelsAround(coordinate: currentPixel, connectivityType: pixelConnectivity).filter({isInBoundary($0, rows: rows, columns: columns)})
                        pixelsAround.forEach { coordinate in
                            if isInBoundary(coordinate, rows: rows, columns: columns) {
                                let pixel = maskGrayScale.value[coordinate.x][coordinate.y]
                                if !pixel.isHole() && !addToBorder[coordinate.x][coordinate.y] {
                                    boundary.insert(coordinate)
                                    addToBorder[coordinate.x][coordinate.y] = true
                                }
                            }
                        }
                    }
                }
            }
        }
  
        holeBody.forEach { u in
            var num: Float = 0
            var deno: Float = 0
            boundary.forEach { v in
                let weight = defaultWeightingFunc(zeta: zeta, epsilon: espilon)(u,v)
                num += weight * sourceGrayscale.value[v.x][v.y].value
                deno += weight
            }
            sourceGrayscale.value[u.x][u.y].value = num / deno
        }
        
       
    }
    
    
    
    /// Get pixels around a given pixel coordinate according to the pixel connectivity
    /// - Parameters:
    ///   - coordinate: pixel coordinate to found the pixels arround
    ///   - connectivityType: pixel connectivity
    /// - Returns: pixels around the pixel given
    func getPixelsAround(coordinate: PixelCoordinate, connectivityType: PixelConnectivityType) -> [PixelCoordinate] {
        var pixels = [PixelCoordinate]()
        pixels.append(contentsOf: [
            PixelCoordinate(x: coordinate.x - 1, y: coordinate.y),
            PixelCoordinate(x: coordinate.x, y: coordinate.y - 1),
            PixelCoordinate(x: coordinate.x, y: coordinate.y + 1),
            PixelCoordinate(x: coordinate.x + 1, y: coordinate.y),
        ])
        
        if connectivityType == .Eight {
            pixels.append(contentsOf: [
                PixelCoordinate(x: coordinate.x - 1, y: coordinate.y + 1),
                PixelCoordinate(x: coordinate.x - 1, y: coordinate.y - 1),
                PixelCoordinate(x: coordinate.x + 1, y: coordinate.y + 1),
                PixelCoordinate(x: coordinate.x + 1, y: coordinate.y - 1),
            ])
        }
        
        return pixels
    }
    
    func convertPixelToImage(matrix: MatrixGrayPixel) -> NSImage? {
     
        var randomMatrix = [[Float]]()
        for _ in 0..<512 {
            var rows = [Float]()
            for _ in 0..<512 {
                rows.append(Float.random(in: 0...1))
            }
            randomMatrix.append(rows)
        }
        var mergedArray = [Float]()
        for row in matrix.value {
            mergedArray.append(contentsOf: row.map({$0.value}))
        }
        
        let pixels = mergedArray.map(PixelData.init(grayValue:))
        
        let rows = randomMatrix.count
        let columns = randomMatrix[0].count
        let pixelSize = MemoryLayout<PixelData>.size
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        let bytesPerRow = columns * pixelSize
        let cgImageSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        let data: Data = pixels.withUnsafeBufferPointer(Data.init(buffer:))
        let cfData = NSData(data: data) as CFData
        
        guard let provider = CGDataProvider(data: cfData),
              let cgImage = CGImage(width: columns,
                                    height: rows,
                                    bitsPerComponent: bitsPerComponent,
                                    bitsPerPixel: bitsPerPixel,
                                    bytesPerRow: bytesPerRow,
                                    space: cgImageSpace,
                                    bitmapInfo: bitmapInfo,
                                    provider: provider,
                                    decode: nil,
                                    shouldInterpolate: true,
                                    intent: .defaultIntent) else {
            return nil
        }
        
        let size = NSSize(width: columns, height: rows)
        let image = NSImage(cgImage: cgImage, size: size)
        return image
    }
}
