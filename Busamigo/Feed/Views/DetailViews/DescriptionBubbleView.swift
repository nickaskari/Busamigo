//
//  DescriptionBubbleView.swift
//  Busamigo
//
//  Created by Nick Askari on 03/06/2022.
//

import SwiftUI

struct DescriptionBubbleView: View {
    private var locationManager: LocationManager
    
    private var feedItem: FeedItem
    private let sightingDict: Dictionary<String, Double>
    
    init(_ feedItem: FeedItem, _ locationManager: LocationManager) {
        self.feedItem = feedItem
        self.locationManager = locationManager
        self.sightingDict = createSightingDict(feedItem.sightingInformation)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .opacity(0.0)
            VStack(alignment: .leading, spacing: 0) {
                DescriptionFeedItemView(feedItem, locationManager)
                    .padding(.bottom)
                
                Divider()
                
                Text("Observatørens karisma:")
                    .font(.headline)
                    .padding()
                KarismaView(value: 68)
                
                if !feedItem.description.isEmpty {
                    Text("Kommentar fra observatør:")
                        .font(.headline)
                        .padding()
                    Text("\(feedItem.description)")
                        .padding(.horizontal)
                        .font(.subheadline)
                }
                Spacer()
            }
        }
    }
}
