//
//  App.swift
//  HoleFilling-Light
//
//  Created by Yankel Melloul on 24/06/2022.
//

import Foundation
import AppKit

class App {
    
    func run(input: [String]) {
        do {
            let parameters = try Validator.validate(arguments: input)
            
            /// Print parameters into the console
            Utils.printParameters(params: parameters)
            
            //// Get NSImage from the path
            let baseImage = getNSImageFrom(path: parameters.imagePath)
            let maskImage = getNSImageFrom(path: parameters.maskPath)
            
            //// Transform Images to graysacle
            guard var baseImageGray = baseImage?.toGrayScaleMatrix(),
                  let maskImageGray = maskImage?.toGrayScaleMatrix() else { return }
            
            
            MediaManager().filledHole(sourceGrayscale: &baseImageGray, maskGrayScale: maskImageGray, zeta: parameters.zeta, espilon: parameters.espsilon, pixelConnectivity: parameters.connectivityTpe)
            
          
            if let image = MediaManager().convertPixelToImage(matrix: baseImageGray) {
                print(image)
                image.save(path: parameters.imageModifiedPath)
            }
            
        } catch(let err) {
            do {
                print("An error occured:")
                if let error = err as? CustomError {
                    print(error.errorDescription as Any)
                } else {
                    print("\(err.localizedDescription)")
                }
                CustomError.printInstructions()
            }
            
        }
    }
    
    
    func getNSImageFrom(path: String) -> NSImage? {
        return NSImage(contentsOfFile: path)
    }
    
  
}
