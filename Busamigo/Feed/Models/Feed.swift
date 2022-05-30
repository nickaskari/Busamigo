//
//  Feed.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import Foundation
import CoreLocation
import SwiftUI

struct Feed {
    
    private(set) var visibleFeed: Array<FeedItem>
    private (set) var untouchedFeed: Array<FeedItem>
    private(set) var isShowingbar: Bool = true

    init(_ inputFeed: Array<FeedItem>) {
        self.visibleFeed = inputFeed
        self.untouchedFeed = inputFeed
        self.standardFilter()
    }
    
    mutating func standardFilter() {
        reset()
        
        self.visibleFeed.sort {
            $0.hotValue > $1.hotValue
        }
    }
    
    mutating func ratingFilter() {
        reset()
        self.visibleFeed.sort {
            $0.voteScore > $1.voteScore
        }
    }
    
    mutating func transportVehicleFilter(_ vehicle: String) {
        standardFilter()
        self.visibleFeed = visibleFeed.filter{ $0.transportVehicle == vehicle }
    }
    
    mutating func locationFilter(_ userLon: Double, _ userLat: Double) {
        reset()
        
        self.visibleFeed.sort {
            distance(lon1: $0.location.longitude, lat1: $0.location.latitude, lon2: userLon, lat2: userLat) <
                distance(lon1: $1.location.longitude, lat1: $1.location.latitude, lon2: userLon, lat2: userLat)
        }
       
    }
    
    //refreshing: database: firebase
    func refreshFeed() {
        
    }
    
    //database: firebase
    mutating func postToFeed(_ feedItem: FeedItem, _ userID: UUID) {
        //user.post()
        self.untouchedFeed.append(feedItem)
        self.visibleFeed.append(feedItem)
    }
    
    private mutating func reset() {
        visibleFeed = untouchedFeed
    }

    //wtf bro, dårlig plassering
    
   mutating func hideBar() {
       self.isShowingbar = false
    }
    
    mutating func showBar() {
        self.isShowingbar = true
    }
    
}
