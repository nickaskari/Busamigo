//
//  ListFeedView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import SwiftUI

struct ListFeedView: View {
    @ObservedObject private var locationManager: LocationManager
    private let feed: [FeedItem]
    
    @State private var searchText = ""
    
    init(_ feed: [FeedItem], _ locationManager: LocationManager) {
        self.feed = feed
        self.locationManager = locationManager
    }

    var body: some View {
        List {
            ForEach(feed) { item in
                ZStack {
                    NavigationLink(destination: {
                        DetailView(feedItem: item, locationManager: locationManager)
                        }, label: {}
                    )
                    .opacity(0)
                    FeedItemView(item)
                        .padding(.bottom, 5)
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
        }
        .id(UUID())
        .listStyle(.plain)
    }
}


