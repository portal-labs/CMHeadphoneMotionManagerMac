//
//  ContentView.swift
//  Shared
//
//  Created by Nick Daniels on 09/06/2022.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var headTracker: HeadTracker
  
  var body: some View {
    VStack {
      HStack {
        Text("\(headTracker.yaw)").padding()
        Text("\(headTracker.pitch)").padding()
        Text("\(headTracker.roll)").padding()
      }
    }.onAppear {
      headTracker.start()
    }.onDisappear {
      headTracker.stop()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
