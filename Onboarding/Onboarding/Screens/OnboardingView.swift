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
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle = "Share."
    
    let haptickFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        
        ZStack {
            Color("ColorBlue")
           
            VStack(spacing: 20) {
                // MARK: HEADER
              
                Spacer()

                VStack(spacing: 0) {
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                    
                    Text("""
It's not how much we give but
how much we put on giving
""")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                } //: HEADER
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0: -40)
                .animation(.easeIn(duration: 1), value: isAnimating)
                
                // MARK: CENTER
                
                ZStack {
                   
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeIn(duration: 1), value: imageOffset)
                
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .opacity(isAnimating ? 1: 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = value.translation
                                        withAnimation(.linear(duration: 0.25)){
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                }) //: Onchange
                                .onEnded({ _ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25)){
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                    }
                                })) //: GESTURE
                        .animation(.easeIn(duration: 1.0), value: imageOffset)
                } //: Center
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 40)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                
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
                                withAnimation(Animation.easeOut(duration: 0.5)){
                                    if buttonOffset > buttonWidth/2 {
                                        haptickFeedback.notificationOccurred(.success)
                                        playSound(sound: "chimeup", type: "mp3")
                                        buttonOffset = buttonWidth - 80
                                        isOnboardingActive = false
                                    } else {
                                        haptickFeedback.notificationOccurred(.warning)
                                        buttonOffset = 0
                                    }
                                }
                            })
                    )
                        Spacer() // Move the button design to left side
                    }
                    
                } // : ZStack
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1: 0)
                .offset(y: isAnimating ? 0: 40)
                .animation(.easeIn(duration: 1.0), value: isAnimating)
                
            } // :VStack
        } // :ZStack
        .ignoresSafeArea()
        .onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Preview: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .previewDevice("iPhone SE (3rd generation)")
    }
}
