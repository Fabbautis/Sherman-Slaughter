//
//  Accelerometer.swift
//  Sherman Slaughter
//
//  Created by Fabian Bautista on 1/27/23.
//

import Foundation
import CoreMotion

var movement = CMMotionManager()
var returnValue: String = ""

func accelerometerCollectData () {
    movement.startAccelerometerUpdates();
    movement.accelerometerUpdateInterval = 1;
    
    Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
        if let data = movement.accelerometerData
        {
            returnValue = String(data.acceleration.x)
            print(returnValue)
        }
    }
}
