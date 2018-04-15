//
//  UIImage+Processing.swift
//  KITT Remote
//
//  Created by George Karavias on 22.03.18.
//  Copyright © 2018 Pinwheel Labs. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func processImage() -> ProcessedImage? {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 160, height: 120), true, 2.0)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(x: 0, y: 0, width: 160, height: 120))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
//        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let rgbColorSpace = CGColorSpaceCreateDeviceGray()
        let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.translateBy(x: 0, y: newImage.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return ProcessedImage(image: newImage, buffer: pixelBuffer)
        
    }
    
}
