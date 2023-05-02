//
//  HomeView.swift
//  ContentView
//
//  Created by Nazim Siddiqui on 02/05/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(Constants.onboading.rawValue) var isOnboardingViewActive: Bool = true
  
  var body: some View {
      ZStack {
          if isOnboardingViewActive {
              OnboardingView()
          } else {
              HomeView()
          }
      }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewDevice("iPhone 13")
      
  }
}
