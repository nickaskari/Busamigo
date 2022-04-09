//
//  FeedItem.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import Foundation
import MapKit


struct FeedItem: Identifiable, Hashable {
    
    //Endre på conceptionDate, tror dette er en tid og ikke klokkeslett
    
    let id = UUID()
    let conceptionDate: Time
    let transportVehicle: String
    private let sighting: String
    private(set) var voteRating: Int
    private(set) var author: User
    private(set) var sightingInformation: String = ""
    private(set) var location: CLLocationCoordinate2D
    private var timeOfSighting: String {
        let hours   = (Calendar.current.component(.hour, from: Date()))
        let minutes = (Calendar.current.component(.minute, from: Date()))
  
        if (hours >= 0 && hours < 10) && (minutes >= 0 && minutes < 10) {
            return "0\(hours):0\(minutes)"
        }
        else if (hours >= 0 && hours < 10) || (minutes >= 0 && minutes < 10) {
            if (hours >= 0 && hours < 10) {
                return "0\(hours):\(minutes)"
            } else {
                return "\(hours):0\(minutes)"
            }
        } else {
            return "\(hours):\(minutes)"
        }
    }
    
    //Location as a computed value?
    //have route and stop as separate variables
    init(sighting: String, transportVehicle: String, author: User, location: CLLocationCoordinate2D, _ voteRating: Int, time: Time) {
        
        self.sighting = sighting
        self.transportVehicle = transportVehicle
        self.author = author
        //for testing
        self.voteRating = voteRating
        self.location = location
        self.conceptionDate = time
        self.sightingInformation = "\(sighting)" + ";" + "\(conceptionDate.hour)" + ":" + "\(conceptionDate.minute)"
        //"\(sighting)" + ";" + "\(timeOfSighting)"
    }
    
    mutating func upVote(user: inout User) {
        if user.canVote(item: self) ==  true {
            voteRating += 1
            author.recieveUpVote()
        }
    }
    
    mutating func downVote(user: inout User) {
        if user.canVote(item: self) ==  true {
            voteRating -= 1
            author.recieveDownVote()
        }
    }
    
    //Posible inherent rating, or credibility value?
    
    
    
    
    
    
    
    
    
    
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(voteRating)
    }
    
    static func == (lhs: FeedItem, rhs: FeedItem) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
}
