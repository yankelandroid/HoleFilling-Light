//
//  WeightingFunc.swift
//  HoleFilling-Light
//
//  Created by Yankel Melloul on 24/06/2022.
//

import Foundation

typealias WeightingFunc = (PixelCoordinate, PixelCoordinate) -> Float

func defaultWeightingFunc(zeta: Float, epsilon: Float) -> WeightingFunc {
    return { u, v -> Float in
        1 / (pow(u.euclideanDistance(with: v), zeta) + epsilon)
    }
}
