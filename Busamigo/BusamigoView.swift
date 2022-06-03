//
//  BusamigoView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI
import MapKit

struct BusamigoView: View {
    @ObservedObject private var feed: AtbFeed = AtbFeed()
    @ObservedObject private var locationManager = LocationManager()
    @ObservedObject private var tabvm = TabViewModel()
  
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
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .environmentObject(PopUpManager())
        .preferredColorScheme(.light)
        .accentColor(.pink)
        .onAppear {
            locationManager.checkIfLocationServicesIsEnabled()
            portraitOrientationLock()
            if getUser() == nil {
                createNewUser()
            }
        }
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BusamigoView()
            BusamigoView()
                .preferredColorScheme(.dark)
        }
    }
}
