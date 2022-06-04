//
//  AppBarView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import SwiftUI

struct AppBarView: View {
    @ObservedObject private var feed: AtbFeed
    @ObservedObject private var locationManager: LocationManager
    
    init(_ feed: AtbFeed, _ locationManager: LocationManager) {
        self.feed = feed
        self.locationManager = locationManager
    }
    
    var body: some View {
        HStack(alignment: .center) {
            
            Image(systemName: "magnifyingglass")
                .font(.system(size: 23))
                .opacity(0)
            
            Image(systemName: "plus")
                .padding(20)
                .font(.system(size: 23))
                .opacity(0)
            
            Spacer()
            
            Image(systemName: "mappin.circle")
                .font(.system(size: 23))
                .shadow(radius: 1)
                .foregroundColor(.pink)
            Text("Trondheim")
                .font(.bold(.title2)())
            
            Spacer()
            
            Image(systemName: "plus")
                .foregroundColor(.pink)
                .font(.system(size: 23))
                .shadow(radius: 1)
                .opacity(0)
            
            NavigationLink(destination: {
                FeedSearchView(feed, locationManager)
            }, label: {
                Image(systemName: "magnifyingglass")
                    .accentColor(.black)
                    .font(.system(size: 23))
                    .shadow(radius: 1)
                    .padding(.horizontal, 20)
            })
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .background(.ultraThinMaterial)
    }
}



struct AppBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppBarView(AtbFeed(), LocationManager())
    }
}
