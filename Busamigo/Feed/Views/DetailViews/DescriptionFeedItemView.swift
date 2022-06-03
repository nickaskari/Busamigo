//
//  DescriptionFeedItemView.swift
//  Busamigo
//
//  Created by Nick Askari on 03/06/2022.
//

import SwiftUI

struct DescriptionFeedItemView: View {
    private var locationManager: LocationManager
    
    private var feedItem: FeedItem
    private let sightingDict: Dictionary<String, Double>
    
    init(_ feedItem: FeedItem, _ locationManager: LocationManager) {
        self.feedItem = feedItem
        self.locationManager = locationManager
        self.sightingDict = createSightingDict(feedItem.sightingInformation)
    }
    
    var body: some View {
        HStack {
            if let route = feedItem.routeInfo {
                Text("\(route.nr)")
                    .foregroundColor(.pink)
                    .font(.largeTitle)
                    .padding(.horizontal)
            } else {
                Image(systemName: "figure.wave")
                    .font(.system(size: 25))
                    .padding(.horizontal)
            }
            VStack(alignment: .leading) {
                ForEach(sightingDict.sorted{return $0.value > $1.value},  id: \.key) { info, textOpacity in
                    Text(info)
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .opacity(textOpacity)
                }
            }
            Spacer()
            if let dist = getCurrentDistance() {
                HStack {
                    Text(dist)
                        .foregroundColor(.pink)
                        .font(.subheadline)
                    Image(systemName: "location.fill")
                        .foregroundColor(.pink)
                        .font(.system(size: 10))
                }
            }
        }
    }
    
    private func getCurrentDistance() -> String? {
        if let userLoc = locationManager.lastKnownLocation {
            var dist = distance(lon1: feedItem.location.longitude, lat1: feedItem.location.latitude, lon2: userLoc.longitude, lat2: userLoc.latitude)
            if dist >= 1000 {
                dist = dist / 1000
                dist = (round(10 * dist) / 10)
                return "\(dist)" + " km "
            } else {
                dist = round(dist)
                return "\(dist)" + " m "
            }
        } else {
            return nil
        }
    }
}
