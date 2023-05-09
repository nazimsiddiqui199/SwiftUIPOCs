//
//  InfoPanelView.swift
//  GesturePOC
//
//  Created by Nazim Siddiqui on 09/05/23.
//

import SwiftUI

struct InfoPanelView: View {
    var scale: CGFloat
    var offset: CGSize
    @State private var isInfoPanelVisisble = false
    var body: some View {
        HStack {
            // MARK: HOTSPOT
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 40, height: 40)
                .onLongPressGesture(minimumDuration: 1) {
                    isInfoPanelVisisble.toggle()
                }
            
            Spacer()
            // MARK: INFO PANEL
            HStack(spacing: 2) {
               
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")
                Spacer()
                
                Image(systemName: "arrow.left.and.left")
                Text("\(offset.height)")
                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 480)
            .opacity(isInfoPanelVisisble ? 1: 0)
            
            Spacer()
        }
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView(scale: 1, offset: .zero)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
