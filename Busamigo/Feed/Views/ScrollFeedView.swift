//
//  Test2View.swift
//  Busamigo
//
//  Created by Nick Askari on 18/02/2022.
//

import SwiftUI
import Foundation

//TODO: fade out the refresher when going down

struct ScrollFeedView: View {
    @ObservedObject private(set) var feed: AtbFeed
    
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @State private var hideProgress: Bool = true
    @State private var activateRefresh: Bool = false
    @State private var didRefresh: Bool = false
    @State private var progressArrow: String
    
    
    init(_ feed: AtbFeed) {
        self.feed = feed
        self.progressArrow = "arrow.down"
    }

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(spacing: 0) {
                    if !hideProgress {
                        progress
                    } else {
                        Image(systemName: progressArrow)
                            .frame(width: 22, height: 22)
                            .position(x: UIScreen.screenWidth / 2, y: -8)
                    }
                    
                    ForEach(feed.getFeed()) { item in
                        NavigationLink(destination: {
                            DetailView(description: item.sightingInformation, location: item.location)
                        }, label: {
                            FeedItemView(rating: item.voteScore, sighting: item.sightingInformation, vehicle: item.transportVehicle)
                        })
                        .buttonStyle(PushDownButtonStyle())
                    }
                }
                .overlay (
                    GeometryReader { proxy -> Color in
                        let minY = proxy.frame(in: .named("SCROLL")).minY
                        let scrollHeight = proxy.frame(in: .named("SCROLL")).height
                        
                        let durationOffset: CGFloat = 10
                        
                        DispatchQueue.main.async {
                            
                            if minY <= 0  {
                                withAnimation {
                                    if !hideProgress && !activateRefresh {
                                        hideProgress = true
                                        feed.showBar()
                                    }
                                }
                                didRefresh = false
                            }
                    
                            if minY > 40 && !didRefresh && !activateRefresh {
                                withAnimation {
                                    hideProgress = false
                                }
                                getTapticFeedBack(style: .medium)
                                activateRefresh = true
                                didRefresh = true
                            }
                            
                            if minY < offset {
                                if offset < 0 && -minY > (lastOffset + durationOffset) && (scrollHeight >= 1000) {
                                    withAnimation(.easeOut.speed(2)) {
                                        feed.hideBar()
                                    }
                                    
                                    lastOffset = -offset
                                }
                                
                            }
                            
                            if minY > offset && -minY < (lastOffset - durationOffset) &&
                            (scrollHeight - -(minY)) >= 870 {
                                withAnimation(.easeIn.speed(2)) {
                                    feed.showBar()
                                }
                                lastOffset = -offset
                            }
                            
                            self.offset = minY
                        }
                        return Color.clear
                    }
                )
            }
            .edgesIgnoringSafeArea(.top)
            .coordinateSpace(name: "SCROLL")
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
    var progress: some View {
        ZStack(alignment: .bottom) {
            ActivityIndicator()
                .foregroundColor(.pink)
                .padding()
                .onChange(of: activateRefresh) { bool in
                    if activateRefresh {
                        print("Just refreshed!")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            print("Ye")
                            activateRefresh = false
                        }
                    }
                }
        }
    }
}








struct ScrollFeedView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollFeedView(AtbFeed())
    }
}
