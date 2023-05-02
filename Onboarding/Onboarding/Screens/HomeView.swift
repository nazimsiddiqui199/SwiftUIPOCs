//
//  HomeView.swift
//  Restart
//
//  Created by Nazim Siddiqui on 02/05/23.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    @AppStorage(Constants.onboading.rawValue) var isOnboardingActive: Bool = true
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
          // MARK: Header
            
            Spacer()
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.3)
                Image("character-2")
                    .resizable()
                .scaledToFit()
            }
            
            //MARK: Center
            
            Text("The time that leads to mystry is depends on the intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            // MARK: Center
            Spacer()
            Button {
                isOnboardingActive = !isOnboardingActive
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
            }
            .font(.system(.title3, design: .rounded))
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        
    }
}

struct HomeView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
