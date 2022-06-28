//
//  Pixel.swift
//  HoleFilling-Light
//
//  Created by Yankel Melloul on 26/06/2022.
//

import Foundation

struct Pixel {
    var r: UInt8 = 0
    var g: UInt8 = 0
    var b: UInt8 = 0
    var a: UInt8 = 0
    
    init(grayValue: Float) {
      let safeValue = grayValue > 0 ? grayValue : 0
      a = 255
      r = UInt8(safeValue * 255)
      g = UInt8(safeValue * 255)
      b = UInt8(safeValue * 255)
    }
    
    init(r: UInt8, g: UInt8, b: UInt8, a:UInt8) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
}

struct GrayPixel {
    var value: Float
    let alpha: UInt8
    
    init(pixel: Pixel) {
        value =  0.245 * Float(pixel.r) + 0.620 * Float(pixel.g) + 0.135 * Float(pixel.b)
        alpha = pixel.a
    }
    
    func isHole() -> Bool {
        return value == 0
    }
}
