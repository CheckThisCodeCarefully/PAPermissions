//
//  PAMotionFitnessPermissionsCheck.swift
//  Pods
//
//  Created by Joseph Blau on 9/24/16.
//
//

import UIKit
import CoreMotion

public class PAMotionFitnessPermissionsCheck: PAPermissionsCheck {
    
    let motionActivityManager = CMMotionActivityManager()
    
    public override func checkStatus() {
        let currentStatus = self.status
        
        if CMMotionActivityManager.isActivityAvailable() {
            if #available(iOS 7.0, *) {
                // There is no way to verifty that motion activity is enabled so assume disabled
                self.status = .disabled
            }
        } else {
            self.status = .unavailable
        }
        
        if self.status != currentStatus {
            self.updateStatus()
        }
    }
    
    public override func defaultAction() {
        
        
        if #available(iOS 7.0, *) {
            motionActivityManager.startActivityUpdates(to: OperationQueue.current!, withHandler: { (motionActivity: CMMotionActivity?) -> Void in
                
                if let motionActivity = motionActivity {
                    self.status = .enabled
                } else {
                    self.status = .disabled
                }
                self.motionActivityManager.stopActivityUpdates()
                self.updateStatus()
            })
        } else {
            // Motion & Fitness Only available above iOS 7
        }
    }
}
