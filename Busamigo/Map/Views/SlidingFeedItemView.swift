//
//  SlidingFeedItemView.swift
//  Busamigo
//
//  Created by Nick Askari on 01/06/2022.
//

import SwiftUI

struct SlidingFeedItemView: View {
    @ObservedObject private var observationManager: ObservationManager
    
    @State private var currentDragOffsetX: CGFloat = 0
    private var observation: FeedItem
    
    init(observation: FeedItem, _ observationManager: ObservationManager) {
        self.observation = observation
        self.observationManager = observationManager
    }
    
    var body: some View {
        FeedItemView(rating: observation.voteScore, sighting: observation.sightingInformation, vehicle: observation.transportVehicle)
            .padding(.bottom, 30)
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
                                withAnimation {
                                    observationManager.mapObservation = nil
                                }
                                currentDragOffsetX = 0
                            }
                        }
                    }
            )
            .transition(.move(edge: .leading))
    }
}


