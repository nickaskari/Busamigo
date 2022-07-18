//
//  FeedView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI
import MapKit

struct FeedView: View {
    @ObservedObject private var feed: FeedManager
    @ObservedObject private var locationManager: LocationManager
    @EnvironmentObject private var popUpManager: PopUpManager
    @EnvironmentObject private var network: Network
    
    private let scrollFeed: ScrollFeedView
    @State private var canPost = false
    
    init(feed: FeedManager, _ locationManager: LocationManager) {
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
                            ZStack(alignment: .top) {
                                scrollFeed
                                if !network.connected {
                                    NetworkErrorView()
                                }
                                else if feed.networkError {
                                    GenericErrorView()
                                } else if feed.newObservations {
                                    NewObservationsView()
                                }
                            }
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
        .onAppear {
            network.checkConnection()
        }
    }
    
    private var addButton: some View {
        Button(action: {
            locationManager.checkIfLocationServicesIsEnabled()
            if locationManager.hasAnyErrors(feed) {
                getTapticFeedBack(style: .medium)
                canPost.toggle()
            } else {
                    withAnimation {
                        getTapticFeedBack(style: .medium)
                        popUpManager.stopSearchIsActive = true
                    }
                }
        }, label: {
            Image(systemName: "plus")
                .addButtonStyle()
        })
        .buttonStyle(PoppingButtonStyle())
        .fullScreenCover(isPresented: $popUpManager.stopSearchIsActive) {
            StopSearchView(feed, locationManager)
        }
        .alert("Busamigo trenger posisjonen din for at du skal poste!", isPresented: $canPost) {
            Button("Skjønner!", role: .cancel) {}
        } message: {
            Text("Sjekk innstillingene dine eller prøv igjen.")
        }
    }
}







struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(feed: FeedManager(), LocationManager())
    }
}
