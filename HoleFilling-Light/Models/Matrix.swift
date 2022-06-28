//
//  Matrix.swift
//  HoleFilling-Light
//
//  Created by Yankel Melloul on 26/06/2022.
//

import Foundation

struct MatrixGrayPixel {
    var value: [[GrayPixel]]
    var rows: Int {
        return value.count
    }
    var columns: Int {
        return value.first?.count ?? 0
    }
    
    init(value: [[GrayPixel]]) {
        self.value = value
    }
}
