//
//  FeedItem.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import Foundation
import MapKit


struct FeedItem: Identifiable, Hashable {
    
    let id = UUID()
    let conceptionDate: Date
    let transportVehicle: String
    private(set) var sightingForSearch: String
    private(set) var voteScore: Int
    private(set) var author: UUID
    private(set) var sightingInformation: String = ""
    private(set) var location: CLLocationCoordinate2D
    private(set) var hotValue: Double
    private var timeOfSighting: String {
        getTimeOfSighting()
    }
    private (set) var description: String
    private(set) var routeInfo: (nr: Int, name: String)?
    
    //have route and stop as separate variables
    init(route: (Int, String)?, stop: String, transportVehicle: String, author: UUID, location: CLLocationCoordinate2D, _ voteScore: Int, description: String) {
        
        if route != nil {
            self.routeInfo = route
            self.sightingForSearch = "\(route?.1 ?? "")" + ";" + "\(stop)"
        } else {
            self.routeInfo = nil
            self.sightingForSearch = "\(stop)"
        }
        
        self.transportVehicle = transportVehicle
        self.author = author
        self.voteScore = voteScore
        self.location = location
        self.description = description
        
        let now = Date()
        self.conceptionDate = now
        self.hotValue = hot(voteScore, now)
        self.sightingInformation = "\(sightingForSearch)" + ";" + "\(timeOfSighting)"
    }
    
    /*mutating func upVote(user: inout User) {
        if user.canVote(item: self) ==  true {
            voteScore += 1
            author.recieveUpVote()
            updateHotValue()
        }
    }
    
    mutating func downVote(user: inout User) {
        if user.canVote(item: self) ==  true {
            voteScore -= 1
            author.recieveDownVote()
            updateHotValue()
        }
    }*/
    
    private mutating func updateHotValue() {
        self.hotValue = hot(voteScore, conceptionDate)
    }
    
    
    
    
    
    
    
    
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(voteScore)
    }
    
    static func == (lhs: FeedItem, rhs: FeedItem) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
}
