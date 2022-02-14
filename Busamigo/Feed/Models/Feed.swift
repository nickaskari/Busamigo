//
//  Feed.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import Foundation

struct Feed {
    
    private var untouched: Array<FeedItem>
    private(set) var visibleFeed: Array<FeedItem>
    
    init(inputFeed: Array<FeedItem>) {
        self.visibleFeed = inputFeed
        self.untouched = inputFeed
        self.standardFilter()
    }
    
    //filtering
    mutating func standardFilter() {
        
        self.visibleFeed = self.untouched
        //Maybe remove badly rated sightings -> -10 or -20
        self.visibleFeed.sort {
            ($0.conceptionDate, $0.voteRating, $0.author.credibility) <
                ($1.conceptionDate, $1.voteRating, $1.author.credibility)
        }
    }
    
    mutating func transportVehicleFilter(_ vehicle: String) {
        
        self.visibleFeed = visibleFeed.filter{ $0.transportVehicle == vehicle }
    }
    
    mutating func ratingFilter() {
        
        self.visibleFeed.sort {
            $0.voteRating < $1.voteRating
        }
    }
    
    //work to be done
    mutating func locationFilter(user: User) {
        LocationManager().requestLocation()
        let UserLocation = user.location
    }
    
    //refreshing: database: firebase
    func refreshFeed() {
        
    }
    
    mutating func addToFeed(_ feedItem: FeedItem) {
        
    }
    
}
