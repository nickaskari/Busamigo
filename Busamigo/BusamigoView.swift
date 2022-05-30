//
//  BusamigoView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI
import MapKit

struct BusamigoView: View {
    @ObservedObject var atbFeed: AtbFeed = AtbFeed()
    @ObservedObject var locationManager = LocationManager()
  
    var body: some View {
        
        TabView {
            FeedView(feed: self.atbFeed, locationManager)
                .tabItem {
                    Label("Feed", systemImage: "house")
                }
            OptionsView()
                .tabItem {
                    Label("Staistikk", systemImage: "list.number")
                }
            MapView(feed: atbFeed)
                .tabItem {
                    Label("Kart", systemImage: "map.fill")
                }
        }
        .environmentObject(PopUpManager())
        .accentColor(.pink)
        .preferredColorScheme(.light)
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
