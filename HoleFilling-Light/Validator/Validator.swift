//
//  Validator.swift
//  HoleFilling-Light
//
//  Created by Yankel Melloul on 24/06/2022.
//

import Foundation

enum Validator {
    
    
    /// Validate the input parameters to let the user to continue
    /// - Parameter arguments: input enters by the user
    /// - Returns: Parameters if all the validation was ok
    static func validate(arguments: [String]) throws -> Parameters {
        
        if arguments.count - 1 < 6 || arguments.count - 1 > 6 {
            throw CustomError.ParametersCount
        }
        
        if let zeta = Float(arguments[3]), let epsilon = Float(arguments[4]), let pixelConnectivity = Int(arguments[5]) {
            return .init(imagePath: arguments[1], maskPath: arguments[2], zeta: zeta, espsilon: epsilon, connectivityTpe: pixelConnectivity == 4 ? .Four : .Eight, weightingFunc: defaultWeightingFunc(zeta: zeta, epsilon: epsilon), imageModifiedPath: arguments[6])
        } else {
            throw CustomError.BadFormat
        }
    }
    
}
