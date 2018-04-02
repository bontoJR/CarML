//
//  DataPoing.swift
//  KITT Remote
//
//  Created by Junior B. on 01.04.18.
//  Copyright © 2018 Bonto.ch. All rights reserved.
//

import Foundation

@objc class DataPoint: NSObject, NSCoding {
    var steering: Float
    var throttle: Float
    var image: String
    
    init(steering: Float, throttle: Float, image: String) {
        self.steering = steering
        self.throttle = throttle
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        steering = aDecoder.decodeFloat(forKey: "steering")
        throttle = aDecoder.decodeFloat(forKey: "throttle")
        image = aDecoder.decodeObject(forKey: "image") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(steering, forKey: "steering")
        aCoder.encode(throttle, forKey: "throttle")
        aCoder.encode(image, forKey: "image")
    }
}
