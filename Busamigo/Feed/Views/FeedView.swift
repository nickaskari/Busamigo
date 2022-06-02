//
//  FeedView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI
import MapKit

struct FeedView: View {
    @ObservedObject var feed: AtbFeed
    @ObservedObject var locationManager: LocationManager
    @EnvironmentObject var popUpManager: PopUpManager
    
    private var scrollFeed: ScrollFeedView
    @State private var isPresented = false
    
    init(feed: AtbFeed, _ locationManager: LocationManager) {
        self.feed = feed
        self.locationManager = locationManager
        self.scrollFeed = ScrollFeedView(feed, locationManager)
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    AppBarView(feed, locationManager)
                    if feed.isShowingBar() {
                        FilterView(feed: feed, locationManager)
                    }
                    Divider()
                        .background(.ultraThinMaterial)
                    ZStack(alignment: .top) {
                        if feed.isLocationError() {
                            let err = feed.getLocationError(locationManager.errors)
                            LocationErrorView(error: err!)
                        } else {
                            scrollFeed
                        }
                    }
                }
                HStack {
                    Spacer()
                    addButton
                    Spacer()
                }
            }
        }
    }
    
    var addButton: some View {
        Button(action: {
            withAnimation {
                getTapticFeedBack(style: .medium)
                popUpManager.stopSearchIsActive = true
            }
            locationManager.checkIfLocationServicesIsEnabled()
        }, label: {
            Image(systemName: "plus")
                .shadow(radius: 2)
                .padding()
                .foregroundColor(.white)
                .font(.system(size: 50))
                .background(Circle()
                    .strokeBorder(.pink, lineWidth: 5)
                    .opacity(0.7))
                .padding()
                .shadow(radius: 6)
        })
        .buttonStyle(PoppingButtonStyle())
        .fullScreenCover(isPresented: $popUpManager.stopSearchIsActive) {
            StopSearchView(feed, locationManager) }
    }
}







struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(feed: AtbFeed(), LocationManager())
    }
}
