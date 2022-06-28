//
//  Parameters.swift
//  HoleFilling-Light
//
//  Created by Yankel Melloul on 24/06/2022.
//

import Foundation

struct Parameters {
    let imagePath: String
    let maskPath: String
    let zeta: Float
    let espsilon: Float
    let connectivityTpe: PixelConnectivityType
    let weightingFunc: WeightingFunc
    let imageModifiedPath: String
}
