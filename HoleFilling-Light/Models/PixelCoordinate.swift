//
//  Coordinate.swift
//  HoleFilling-Light
//
//  Created by Yankel Melloul on 24/06/2022.
//

import Foundation

struct PixelCoordinate: Hashable {
    let x: Int
    let y: Int
}

extension PixelCoordinate {
    func euclideanDistance(with coordinate : PixelCoordinate) -> Float {
        let horizontalDist: Float = pow(Float(x - coordinate.y), 2)
        let verticalDist: Float = pow(Float(x - coordinate.y), 2)
        return sqrt(horizontalDist + verticalDist)
    }
    
    func isInBounds(rows: Int, columns: Int) -> Bool {
        return x >= 0 && x < rows && y >= 0 && y < columns
    }
}
