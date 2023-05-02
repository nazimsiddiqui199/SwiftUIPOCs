//
//  OnboardingView.swift
//  Restart
//
//  Created by Nazim Siddiqui on 02/05/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage(Constants.onboading.rawValue) var isOnboardingActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    
    var body: some View {
        
        ZStack {
            Color("ColorBlue")
           
            VStack(spacing: 20) {
                // MARK: HEADER
              
                Spacer()

                VStack(spacing: 0) {
                    Text("Share.")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("""
It's not how much we give but
how much we put on giving
""")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                }

                
                // MARK: CENTER
                
                ZStack {
                   
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                } //: Center
                
                Spacer()
                
                // MARK: FOOTER
                
                ZStack {
                    Text("Get Started")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x:20)
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    HStack {
                        Capsule()
                            .fill(Color.red)
                            .frame(width: buttonOffset + 80)
                        Spacer() // To shift red capsule on left side
                    }
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(.red)
                            Circle()
                            .fill(.black.opacity(0.15))
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                            
                        }
                        .foregroundColor(.white)
                    .frame(width: 80, height: 80, alignment: .center)
                    .offset(x: buttonOffset)
                    .gesture(
                        DragGesture()
                            .onChanged({ gesture in
                                if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                    buttonOffset = gesture.translation.width
                                }
                                
                            })
                            .onEnded({ _ in
                                if buttonOffset > buttonWidth/2 {
                                    buttonOffset = buttonWidth - 80
                                    isOnboardingActive = false
                                } else {
                                    buttonOffset = 0
                                }
                            })
                    )
                        Spacer() // Move the button design to left side
                    }
                    
                } // : ZStack
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                
                
            } // :VStack
        } // :ZStack
        .ignoresSafeArea()
        
      
        
    }
}

struct OnboardingView_Preview: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .previewDevice("iPhone SE (3rd generation)")
    }
}
