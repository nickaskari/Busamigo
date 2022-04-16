//
//  Test2View.swift
//  Busamigo
//
//  Created by Nick Askari on 18/02/2022.
//

import SwiftUI
import Foundation
import MapKit

struct Test2View: View {
    @ObservedObject var feed = AtbFeed()
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @State private var hideProgress: Bool = true
    @State private var progressOpacity: Double = 0
    @State private var activateRefresh: Bool = false
    @State private var usedOffset: Array<CGFloat> = []
    @State private var didRefresh: Bool = false
    @State private var speed: Double = 0.5
    @State private(set) var hideBar: Bool = false

    var body: some View {
        ZStack(alignment: .top) {
            if !hideProgress {
                progress
            }
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(spacing: 5) {
                    if !hideProgress {
                        dummy
                    }
                    ForEach(feed.getFeed()) { item in
                        FeedItemView(rating: item.voteScore, sighting: item.sightingInformation, vehicle: item.transportVehicle)
                    }
                    Button(action: {
                        feed.activateFilter("Relevant", userLon: nil, userLat: nil)
                    }, label: {Circle().foregroundColor(.pink).frame(width: 40, height: 40)})
                }
                .overlay (
                    GeometryReader { proxy -> Color in
                        
                        let minY = proxy.frame(in: .named("SCROLL")).minY
                        let scrollHeight = proxy.frame(in: .named("SCROLL")).height
                        
                        let durationOffset: CGFloat = 10
                        
                        DispatchQueue.main.async {
                            
                            
                            if offset <= 0  {
                                withAnimation {
                                    hideProgress = true
                                }
                                didRefresh = false
                                progressOpacity = 0
                                self.usedOffset = []
                            }
                            
                            if offset > 10 {
                                if hideProgress {
                                    withAnimation {
                                        hideProgress = false
                                    }
                                }
                                if Int(offset) % 3 == 0 && !usedOffset.contains(offset) {
                                    progressOpacity += 0.1
                                    speed += 0.1
                                    self.usedOffset.append(offset)
                                }
                            }
                            if progressOpacity >= 1 && !didRefresh {
                                
                                getTapticFeedBack(style: .medium)
                                activateRefresh = true
                                didRefresh = true
                            }
                            
                            if minY < offset {
                                if offset < 0 && -minY > (lastOffset + durationOffset) && (scrollHeight >= 1000) {
                                    withAnimation(.easeOut.speed(2)) {
                                        hideBar = true
                                    }
                                    
                                    lastOffset = -offset
                                }
                                
                            }
                            if minY > offset && -minY < (lastOffset - durationOffset) &&
                            (scrollHeight - -(minY)) >= 870 {
                                withAnimation(.easeIn.speed(2)) {
                                    hideBar = false
                                }
                                
                                lastOffset = -offset
                                
                            }
                            
                            self.offset = minY
                        }
                        return Color.clear
                    }
                )
            }
            .coordinateSpace(name: "SCROLL")
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .progressViewStyle(PinkProgressViewStyle())
    }
    
    var progress: some View {
        ZStack(alignment: .bottom) {
            ProgressView()
                .foregroundColor(.pink)
                .scaleEffect(1.3)
                .opacity(progressOpacity)
                .padding()
                .onChange(of: activateRefresh) { opacity in
                    if activateRefresh {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                feed.activateFilter("Buss", userLon: nil, userLat: nil)
                            }
                            activateRefresh = false
                        }
                    }
                }
        }
    }
    
    var dummy: some View {
        ZStack(alignment: .bottom) {
            ProgressView()
                .scaleEffect(1.3)
                .padding()
                .opacity(0)
        }
    }
}


struct PinkProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .tint(.pink)
    }
}








struct Test2View_Previews: PreviewProvider {
    static var previews: some View {
        Test2View()
    }
}
