//
//  BusamigoView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI
import MapKit

struct BusamigoView: View {
    @ObservedObject private var feed: AtbFeed
    @ObservedObject private var locationManager: LocationManager
    
    @EnvironmentObject private var tabvm: TabViewModel
    @EnvironmentObject private var userManager: UserManager
    @EnvironmentObject private var network: Network
  
    init(_ feed: AtbFeed, _ locationManager: LocationManager) {
        self.feed = feed
        self.locationManager = locationManager
    }
    
    var body: some View {
        VStack(spacing: -3.7) {
            switch tabvm.currentPage {
            case .feed:
                FeedView(feed: feed, locationManager)
            case .profile:
                ProfileView()
            case .map:
                MapView(feed: feed, locationManager)
            }
            
            Spacer()

            BusamigoTabView(feed, tabvm)
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .accentColor(.pink)
        /*.onAppear {
            locationManager.checkIfLocationServicesIsEnabled()
            portraitOrientationLock()
            feed.listenForUpdates()
            
        }
        .task {
            await userManager.signIn()
        }*/
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BusamigoView(AtbFeed(), LocationManager())
            BusamigoView(AtbFeed(), LocationManager())
                .preferredColorScheme(.dark)
        }
    }
}
