//
//  ListFeedView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import SwiftUI
import UIKit

struct ListFeedView: View {
    @ObservedObject var feed: AtbFeed
    @State private var selected: FeedItem? = nil
    
    init(_ feed: AtbFeed) {
        self.feed = feed
    }

        var body: some View {
            List(feed.getFeed()) { item in
            
                ZStack {
                    NavigationLink(destination: {
                        DetailView(description: item.sightingInformation, location: item.location)
                        }, label: {}
                    )
                    .opacity(0)
                    .onTapGesture {
                        selected = item
                    }
                    FeedItemView(rating: item.voteScore, sighting: item.sightingInformation, vehicle: item.transportVehicle)
                }
                .listRowBackground(self.selected != nil ? Color.gray : Color.clear)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .refreshable {
                feed.activateFilter("Buss", userLon: nil, userLat: nil)
            }
        }
}






struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        ListFeedView(AtbFeed())
    }
}
