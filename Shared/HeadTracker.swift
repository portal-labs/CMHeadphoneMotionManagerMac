//
//  HeadTracking.swift
//  CMHeadphoneMotion
//
//  Created by Nick Daniels on 09/06/2022.
//

import SwiftUI
import Combine
import CoreMotion

class HeadTracker: ObservableObject {
  @Published var yaw: Double = 0.0
  @Published var pitch: Double = 0.0
  @Published var roll: Double = 0.0
  
  static var shared: HeadTracker = {
    HeadTracker()
  }()
  
  lazy var headTrackerManager = {
    HeadTrackerManager()
  }()
  
  func start() {
    headTrackerManager.start() { (yaw, pitch, roll) in
      self.yaw = yaw
      self.pitch = pitch
      self.roll = roll
    }
  }
  
  func stop() {
    headTrackerManager.stop()
  }
}

class HeadTrackerManager: NSObject, CMHeadphoneMotionManagerDelegate {
  var motionManager: CMHeadphoneMotionManager!
  
  override init() {
    super.init()

    motionManager = CMHeadphoneMotionManager()
    motionManager.delegate = self
  }
  
  func start(_ callback: @escaping (Double, Double, Double) -> Void) {
    print("Start tracking")
    
    if motionManager.isDeviceMotionAvailable {
      motionManager.startDeviceMotionUpdates (to: OperationQueue.main) { (motion, error) in
        // get data
        let yawInRadians = (motion?.attitude.yaw)!
        let pitchInRadians = (motion?.attitude.pitch)!
        let rollInRadians = (motion?.attitude.roll)!

        callback(yawInRadians, pitchInRadians, rollInRadians)
        print(yawInRadians, pitchInRadians, rollInRadians)
      }
    } else {
      print("Device motion not available")
    }
  }
  
  func stop() {
    print("Stop tracking")
    motionManager.stopDeviceMotionUpdates()
  }
  
  // delegated methods for motion manager
  func headphoneMotionManagerDidConnect(_ manager: CMHeadphoneMotionManager) {
      print ("MotionManager connected!")
  }

  func headphoneMotionManagerDidDisconnect(_ manager: CMHeadphoneMotionManager) {
      print ("MotionManager disconnect!")
  }
}
