//
//  PixelData.swift
//  HoleFilling-Light
//
//  Created by Yankel Melloul on 28/06/2022.
//

import Foundation

struct PixelData {
  var a: UInt8 = 0
  var r: UInt8 = 0
  var g: UInt8 = 0
  var b: UInt8 = 0
  
  init(grayValue: Float) {
    let safeValue = grayValue > 0 ? grayValue : 0
    a = 255
    r = UInt8(safeValue)
    g = UInt8(safeValue)
    b = UInt8(safeValue)
  }
}
