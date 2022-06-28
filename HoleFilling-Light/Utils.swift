//
//  Utils.swift
//  HoleFilling-Light
//
//  Created by Yankel Melloul on 24/06/2022.
//

import Foundation

enum Utils {
    static func printParameters(params: Parameters) {
        print("▫️  ImagePath: \(params.imagePath)")
        print("▫️  MaskPath: \(params.maskPath)")
        print("▫️  Zeta: \(params.zeta)")
        print("▫️  Espsilon: \(params.espsilon)")
        print("▫️  ImageModifiedPath: \(params.imageModifiedPath)")
    }
}
