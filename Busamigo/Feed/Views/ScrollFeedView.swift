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
    @ObservedObject private var feed: FeedManager
    @ObservedObject private var locationManager: LocationManager
    @EnvironmentObject private var homeButtonManager: HomeButtonManager
    @EnvironmentObject private var network: Network
    
    
    @FetchRequest(sortDescriptors: []) var hiddenObservations: FetchedResults<HiddenObservations>
    @Environment(\.managedObjectContext) var moc
    
    @AppStorage("areAdsEnabled") var areAdsEnabled: Bool = false
    
    @State private var hideProgress: Bool = true
    @State private var activateRefresh: Bool = false
    @State private var didRefresh: Bool = false
    
    init(_ feed: FeedManager, _ locationManager: LocationManager) {
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
                            if !isHidden(obs) {
                                makeObservation(obs)
                            }
                            
                            if (feed.getPositionInVisibleFeed(observation: obs) % 3) == 0  && network.connected &&
                                areAdsEnabled {
                                AdView(adFormat: .mediumRectangle)
                                    .id(feed.getPositionInVisibleFeed(observation: obs))
                            }
                        }
                    } else {
                        EmptyFeedView()
                            .position(x: UIScreen.screenWidth / 2, y: UIScreen.screenHeight / 4)
                    }
        
                }
                .onReceive(homeButtonManager.$scrollToTop, perform: { scroll in
                    if homeButtonManager.scrollToTop {
                        withAnimation {
                            value.scrollTo(0)
                        }
                    }
                })
                .overlay (
                    GeometryReader { proxy -> Color in
                        let minY = proxy.frame(in: .named("SCROLL")).minY
                        
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
    
    private func isHidden(_ obs: Observation) -> Bool {
        hiddenObservations.contains(where: {
            if let docID = $0.docID {
                if docID == obs.id {
                    feed.removeObservation(obs)
                    return true
                }
            }
            return false
        })
    }
    
    private func deleteHidingLog() {
        for docID in hiddenObservations {
            moc.delete(docID)
        }
        try? moc.save()
    }
}













struct ScrollFeedView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollFeedView(FeedManager(), LocationManager())
    }
}
