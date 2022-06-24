//
//  FeedSearchView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import SwiftUI

struct FeedSearchView: View {
    @ObservedObject var feed: AtbFeed
    @ObservedObject var locationManager: LocationManager
    @State private var searchText = ""
    
    init (_ feed: AtbFeed, _ locationManager: LocationManager) {
        self.feed = feed
        self.locationManager = locationManager
    }
    
    var body: some View {
        ListFeedView(filteredFeed, locationManager)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Søk buss/trikk eller holdeplasser")
            .navigationBarTitle("Søk i feeden", displayMode: .inline)
    }
    
    private var filteredFeed: [Observation] {
        if searchText.isEmpty {
            return []
        } else {
            return feed.getUntouchedFeed().filter { $0.searchInfo.localizedStandardContains(searchText)}
        }
    }
}








struct FeedSearchView_Previews: PreviewProvider {
    static var previews: some View {
        FeedSearchView(AtbFeed(), LocationManager())
    }
}
