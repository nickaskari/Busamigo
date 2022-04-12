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
    private var untouchedFeed: Array<FeedItem>

    init(_ inputFeed: Array<FeedItem>) {
        self.visibleFeed = inputFeed
        self.untouchedFeed = inputFeed
        self.standardFilter()
    }
    
    mutating func standardFilter() {
        //Maybe remove badly rated sightings -> -10 or -20
        reset()
        
        self.visibleFeed.sort {
            ($0.conceptionDate, $0.voteRating, $0.author.credibility) >
                ($1.conceptionDate, $1.voteRating, $1.author.credibility)
        }
    }
    
    mutating func ratingFilter() {
        reset()
        self.visibleFeed.sort {
            $0.voteRating > $1.voteRating
        }
    }
    
    mutating func transportVehicleFilter(_ vehicle: String) {
        standardFilter()
        self.visibleFeed = visibleFeed.filter{ $0.transportVehicle == vehicle }
    }
    
    mutating func locationFilter(_ userLon: Double, _ userLat: Double) {
        
        self.visibleFeed.sort {
            distance(lat1: $0.location.latitude, lat2: $0.location.longitude, lon1: userLon, lon2: userLat) <
                distance(lat1: $1.location.latitude, lat2: $1.location.longitude, lon1: userLon, lon2: userLat)
        }
       
    }
    
    //refreshing: database: firebase
    func refreshFeed() {
        
    }
    
    //database: firebase
    mutating func addToFeed(_ feedItem: FeedItem, user: User) {
        self.untouchedFeed.append(feedItem)
        self.visibleFeed.append(feedItem)
    }
    
    private mutating func reset() {
        visibleFeed = untouchedFeed
    }
 
}
