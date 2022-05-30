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
        self.scrollFeed = ScrollFeedView(feed)
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    AppBarView()
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
                }
            }
        }
    }
    
    var addButton: some View {
        Button(action: {
            getTapticFeedBack(style: .medium)
            popUpManager.stopSearchIsActive = true
            locationManager.checkIfLocationServicesIsEnabled()
        }, label: {
            Image(systemName: "plus")
                .shadow(radius: 1)
                .padding()
                .foregroundColor(.white)
                .font(.system(size: 50))
                .background(Circle().foregroundColor(.pink))
                .padding()
                .shadow(radius: 5)
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
