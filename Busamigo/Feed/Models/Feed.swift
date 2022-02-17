//
//  Feed.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import Foundation
import CoreLocation

struct Feed {
    
    private(set) var visibleFeed: Array<FeedItem>
    
    private var untouched: Array<FeedItem>
    private var isVehicleFiltered: Bool = false
    private var isRatingFiltered: Bool = false
    private var isLocationFiltered: Bool = false
    
    init(inputFeed: Array<FeedItem>) {
        self.visibleFeed = inputFeed
        self.untouched = inputFeed
        self.standardFilter()
    }
    
    mutating func standardFilter() {
        //Maybe remove badly rated sightings -> -10 or -20
        self.visibleFeed.sort {
            ($0.conceptionDate, $0.voteRating, $0.author.credibility) <
                ($1.conceptionDate, $1.voteRating, $1.author.credibility)
        }
    }
    
    mutating func ratingFilter(user: User) {
        self.isRatingFiltered.toggle()
        
        if self.isRatingFiltered {
            self.visibleFeed.sort {
                $0.voteRating < $1.voteRating
            }
        } else {
            activeFilters(user)
        }
    }
    
    mutating func locationFilter(user: User) {
        self.isLocationFiltered.toggle()
        
        if self.isLocationFiltered {
            let manager = LocationManager()
            manager.requestLocation()
            let userLon = user.location!.longitude
            let userLat = user.location!.longitude
            
            self.visibleFeed.sort {
                manager.distance(lat1: $0.location.latitude, lat2: $0.location.longitude, lon1: userLon, lon2: userLat) <
                    manager.distance(lat1: $1.location.latitude, lat2: $1.location.longitude, lon1: userLon, lon2: userLat)
            }
        } else {
            activeFilters(user)
        }
        
    }
    
    mutating func transportVehicleFilter(_ vehicle: String, user: User) {
        self.isVehicleFiltered.toggle()
        
        if self.isVehicleFiltered {
            self.visibleFeed = visibleFeed.filter{ $0.transportVehicle == vehicle }
        } else {
            let missingItems = self.untouched.filter{ $0.transportVehicle == vehicle }
            self.visibleFeed.append(contentsOf: missingItems)
            activeFilters(user)
        }
        
    }
    
    //refreshing: database: firebase
    func refreshFeed() {
        
    }
    
    //database: firebase
    mutating func addToFeed(_ feedItem: FeedItem, user: User) {
        self.untouched.append(feedItem)
        self.visibleFeed.append(feedItem)
        activeFilters(user)
    }
    
    private mutating func activeFilters(_ user: User) {
        if self.isLocationFiltered {
            locationFilter(user: user)
        }
        if self.isRatingFiltered {
            ratingFilter(user: user)
        } else {
            standardFilter()
        }
    }
    
}
