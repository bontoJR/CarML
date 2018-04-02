//
//  DataController.swift
//  KITT Remote
//
//  Created by Junior B. on 01.04.18.
//  Copyright © 2018 Bonto.ch. All rights reserved.
//

import Foundation
import UIKit

class DataController {
    
    static let shared = DataController()
    var dataPoints = [DataPoint]()
    var fileHandle: FileHandle?
    let documentDirectory = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }()
    
    init() {
        openDataFile()
    }
    
    fileprivate func openDataFile() {
        guard fileHandle == nil else { return }
        let filePath = documentDirectory.appendingPathComponent("data.csv")
        if !FileManager.default.fileExists(atPath: filePath.path) {
            let emptyData = "".data(using: .utf8)!
            guard let _ = try? emptyData.write(to: filePath) else {
                fatalError("Empty file failed to be created.")
            }
        }
        if let fileHandle = FileHandle(forWritingAtPath: filePath.path) {
            fileHandle.seekToEndOfFile()
            self.fileHandle = fileHandle
        }
    }
    
    func savePointForImage(steering: Float, throttle: Float, image: UIImage) {
        openDataFile()
        let uuid = UUID.init().uuidString
        let imageName = "\(uuid).png"
        if let data = UIImagePNGRepresentation(image) {
            let path = documentDirectory.appendingPathComponent(imageName)
            if let _ = try? data.write(to: path) {
                let data = "\(steering),\(throttle),\(imageName)\n".data(using: .utf8)
                fileHandle?.write(data!)
            }
        }
    }
    
    deinit {
        fileHandle?.closeFile()
        fileHandle = nil
    }
}
