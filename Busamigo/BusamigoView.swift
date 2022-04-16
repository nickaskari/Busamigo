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
                    Label("Options", systemImage: "line.horizontal.3")
                }
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
        }
        .accentColor(.pink)
        .preferredColorScheme(.light)
        .onAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            AppDelegate.orientationLock = .portrait
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
