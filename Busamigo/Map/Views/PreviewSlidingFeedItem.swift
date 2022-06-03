//
//  PreviewSlidingFeedItem.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI

struct PreviewSlidingFeedItem: View {
    @State private var currentDragOffsetX: CGFloat = 0
    @State private var outOfScreen = false
    
    var body: some View {
        if !outOfScreen {
            FeedItemView(rating: 12, sighting: "Lohove mot sentrum;Kongens gate;1345", routeNr: 3)
                .disabled(true)
                .frame(height: 200)
                .padding(.horizontal)
                .offset(x: currentDragOffsetX)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation {
                                currentDragOffsetX = value.translation.width
                            }
                        }
                        .onEnded { value in
                            if currentDragOffsetX < 150 {
                                withAnimation {
                                    currentDragOffsetX = 0
                                }
                            } else {
                                withAnimation {
                                    currentDragOffsetX = UIScreen.screenWidth
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    withAnimation(.easeIn) {
                                        outOfScreen = true
                                    }
                                }
                            }
                        }
                )
        } else {
            Text("Du klarte det🥳")
                .font(.headline)
                .frame(height: 200)
        }
    }
}
