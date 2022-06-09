//
//  CMHeadphoneMotionApp.swift
//  Shared
//
//  Created by Nick Daniels on 09/06/2022.
//

import SwiftUI

@main
struct CMHeadphoneMotionApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(HeadTracker.shared)
    }
  }
}
