//
//  Test2View.swift
//  Busamigo
//
//  Created by Nick Askari on 18/02/2022.
//

import SwiftUI
import Foundation
import GoogleMobileAds

struct ScrollFeedView: View {
    @ObservedObject private var feed: AtbFeed
    @ObservedObject private var locationManager: LocationManager
    @EnvironmentObject private var scrollManager: ScrollManager
    @EnvironmentObject private var network: Network
    
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @State private var hideProgress: Bool = true
    @State private var activateRefresh: Bool = false
    @State private var didRefresh: Bool = false
    
    
    init(_ feed: AtbFeed, _ locationManager: LocationManager) {
        self.feed = feed
        self.locationManager = locationManager
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ScrollViewReader { value in
                LazyVStack(spacing: 5) {
                    EmptyView()
                        .id(0)
                    
                    if !hideProgress {
                        progress
                    } else {
                        progressArrow
                    }
                    
                    if !feed.getVisibleFeed().isEmpty {
                        ForEach(feed.getVisibleFeed()) { obs in
                            makeObservation(obs)
                            
                            if (feed.getPositionInVisibleFeed(observation: obs) % 3) == 0  && network.connected {
                                makeAd()
                            }
                        }
                    } else {
                        EmptyFeedView()
                            .position(x: UIScreen.screenWidth / 2, y: UIScreen.screenHeight / 4)
                    }
        
                }
                .onReceive(scrollManager.$scrollToTop, perform: { scroll in
                    if scrollManager.scrollToTop {
                        withAnimation {
                            value.scrollTo(0)
                        }
                    }
                })
                .overlay (
                    GeometryReader { proxy -> Color in
                        let minY = proxy.frame(in: .named("SCROLL")).minY
                        //let scrollHeight = proxy.frame(in: .named("SCROLL")).height
                        
                        //let durationOffset: CGFloat = 10
                        
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
                    
                            if minY > 80 && !didRefresh && !activateRefresh {
                                withAnimation {
                                    hideProgress = false
                                }
                                getTapticFeedBack(style: .medium)
                                activateRefresh = true
                                didRefresh = true
                            }
                            
                           /* if minY < offset {
                                if offset < 0 && -minY > (lastOffset + durationOffset) && (scrollHeight >= 1000) {
                                    withAnimation(.easeOut.speed(2)) {
                                        feed.hideBar()
                                    }
                                    lastOffset = -offset
                                }
                                
                            }
                            
                            if minY > offset {
                                if -minY < (lastOffset - durationOffset) &&
                                        (scrollHeight - -(minY)) >= 870 {
                                    withAnimation(.easeIn.speed(2)) {
                                        feed.showBar()
                                    }
                                    lastOffset = -offset
                                }
                            }
                            
                            self.offset = minY*/
                        }
                        return Color.clear
                    }
                )
            }
        }
        .edgesIgnoringSafeArea(.top)
        .coordinateSpace(name: "SCROLL")
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    private var progress: some View {
        ActivityIndicator(color: .pink)
            .onChange(of: activateRefresh) { bool in
                if activateRefresh {
                    feed.fetchFeed { success in
                        if success {
                            feed.activateFilter("Relevant", userLon: nil, userLat: nil)
                            activateRefresh = false
                        } else {
                            withAnimation {
                                feed.networkError = true
                            }
                        }
                    }
                }
            }
        
    }
    
    private var progressArrow: some View {
        Image(systemName: "arrow.down")
            .frame(width: 22, height: 12)
            .position(x: UIScreen.screenWidth / 2, y: -8)
    }
    
    private func makeObservation(_ item: Observation) -> some View {
        NavigationLink(destination: {
            DetailView(observation: item, locationManager: locationManager)
        }, label: {
            ObservationView(item)
        })
        .buttonStyle(NonHighlightingButtonStyle())
    }
    
    private func makeAd() -> some View {
        
        ZStack {
            ActivityIndicator(color: .pink)
            
            GADBannerViewController()
                .frame(width: GADAdSizeMediumRectangle.size.width, height: GADAdSizeMediumRectangle.size.height)
                .padding()
        }
    }
}













struct ScrollFeedView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollFeedView(AtbFeed(), LocationManager())
    }
}
