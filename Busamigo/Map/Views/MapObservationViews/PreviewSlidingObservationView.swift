//
//  PreviewSlidingObservationView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI
import MapKit

struct PreviewSlidingObservationView: View {
    @State private var currentDragOffsetX: CGFloat = 0
    @State private var outOfScreen = false
    
    private let preview = Observation(route: Route(nr: 3, name: "Lohove mot sentrum"), stop: Stop(name: "Kongens gate", vehicle: 700), author: "someID", location: CLLocationCoordinate2D(), voteScore: 12, description: "")
    
    var body: some View {
        if !outOfScreen {
            ObservationView(preview)
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
