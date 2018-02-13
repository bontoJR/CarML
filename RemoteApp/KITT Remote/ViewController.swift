//
//  ViewController.swift
//  KITT Remote
//
//  Created by Junior B. on 06.02.18.
//  Copyright © 2018 Bonto.ch. All rights reserved.
//

import UIKit
import SocketIO

let stringURL = "http://kitt.local:9090/stream/video.mjpeg"

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var leftJoystick: CDJoystick!
    @IBOutlet weak var rightJoystick: CDJoystick!
    var steering: Float = 0.0
    var speed: Float = 0.0
    var delta: Float = 0.05
    
    var streamingController: StreamingController!
    let manager = SocketManager(socketURL: URL(string: "http://kitt.local:8080")!, config: [.log(true), .compress])
    lazy var socket = manager.socket(forNamespace: "/drive")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        streamingController = StreamingController(imageView: imageView)
        
        // socket.io
        socket.on(clientEvent: .connect) { data, ack in
            print("socket connected")
        }
        
        socket.connect()
        
        leftJoystick.trackingHandler =  { data in
            let newVal = -1.0 * Float(data.velocity.x)
            if (fabsf(self.steering - newVal) > self.delta) {
                self.steering = newVal
                self.socket.emit("setSteering", with: [self.steering])
            }
        }
        
        rightJoystick.trackingHandler =  { data in
            let newVal = Float(data.velocity.y)
            if (fabsf(self.speed - newVal) > self.delta) {
                self.speed = newVal
                self.socket.emit("setSpeed", with: [self.speed])
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        streamingController.play(url: URL(string: stringURL)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
