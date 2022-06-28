//
//  CustomError.swift
//  HoleFilling-Light
//
//  Created by Yankel Melloul on 24/06/2022.
//

import Foundation

enum CustomError: LocalizedError {
    case ParametersCount
    case BadFormat
    
    var errorDescription: String? {
        switch self {
        case .ParametersCount:
            return "You need to enter all the parameters needed."
        case .BadFormat:
            return "Please check the format of your inputs"
        }
    }
    
    static func printInstructions() {
        print("You need to enter the following parameters: ")
        print("-- Source Image Path --")
        print("-- Mask Image Path --")
        print("-- Zeta as numeric (ex: 2) --")
        print("-- Epsilon as numeric (ex: 0.001) --")
        print("-- Pixel connectivity as integer (4 or 8) --")
        print("-- Result Image Path --")
    }
}
