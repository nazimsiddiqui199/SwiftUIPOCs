//
//  ContentView.swift
//  GesturePOC
//
//  Created by Nazim Siddiqui on 08/05/23.
//

import SwiftUI

struct ContentView: View {
    // MARK: PROPERTY
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    private let maximumImageScale: CGFloat = 5
    private let minimuImageScale: CGFloat = 1
    @State private var isDrarwerOpened = false
    let pages = PagesManager.pagesData
    @State var pageIndex = 1
    
      // MARK: FUNCTION
    private func resetImageState() {
        return withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
        }
    }
    
      
      // MARK: CONTENT
      
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                // MARK: PAGE IMAGE
                Image(pages[pageIndex - 1].imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                // MARK: TAP GESTURE
                    .onTapGesture(count: 2) {
                        // Optimised code for below if else condition
//                        imageScale == 1 ? withAnimation(.spring()){ imageScale = 5 } : withAnimation(.spring()) { imageScale = 1 }
                        if imageScale == 1 {
                            withAnimation(.spring()){
                                imageScale = maximumImageScale
                            }
                        } else {
                            resetImageState()
                        }
                    }
                
                // MARK: DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                if value.translation.width >= 0 || value.translation.height >= 0 {
                                    withAnimation(.linear(duration: 1)){
                                        imageOffset = value.translation
                                    }
                                }
                            })
                            .onEnded({ _ in
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            })
                    )
                    
            }
            // MARK: MAGNIFICATION
            .gesture(
                MagnificationGesture()
                    .onChanged({ value in
                        withAnimation(.linear(duration: 1)){
                            if imageScale >= 1 && imageScale <= 5 {
                                imageScale = value
                            }else if imageScale > maximumImageScale {
                                imageScale = maximumImageScale
                            }
                        }
                    })
                    .onEnded({ value in
                        if imageScale > maximumImageScale {
                            imageScale = maximumImageScale
                        } else if imageScale <= minimuImageScale {
                            resetImageState()
                        }
                    })
            )
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)){
                    isAnimating = true
                }
            })
            // MARK: INFO PANEL
            .overlay(alignment: .top, content: {
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
            })
            // MARK: CONTROLS
            .overlay(alignment: .bottom) {
                Group {
                    HStack {
                        // SCALE DOWN
                        Button {
                            withAnimation(.spring()){
                                if imageScale > minimuImageScale {
                                    imageScale -= 1
                                    if imageScale <= minimuImageScale {
                                        resetImageState()
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        // RESET
                        Button {
                            resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        // SCALE UP
                        Button {
                            withAnimation(.spring()){
                                if imageScale < maximumImageScale {
                                    imageScale += 1
                                    if imageScale > maximumImageScale {
                                        imageScale = maximumImageScale
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                    } //: CONTROLS
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 20, trailing: 12))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                    
                }
            }
            // MARK: DRAWER
            .overlay(alignment: .topTrailing) {
                HStack(spacing: 12) {
                    Image(systemName: isDrarwerOpened ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            withAnimation(.easeOut){
                                isDrarwerOpened.toggle()
                            }
                        }
                    
                    // MARK: Thumbnail
                    ForEach(pages) { page in
                        Image(page.thumbnailImage)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .opacity(isDrarwerOpened ? 1 : 0)
                            .animation(.easeOut(duration: 0.5), value: isDrarwerOpened)
                            .onTapGesture {
                                isAnimating = true
                                pageIndex = page.id
                            }
                    }
                    
                    Spacer()
                }
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .opacity(isAnimating ? 1: 0)
                .frame(width: 260)
                .padding(.top, UIScreen.main.bounds.height/12)
                .offset(x: isDrarwerOpened ? 20: 215)
            }
            
        }.navigationViewStyle(.stack)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
