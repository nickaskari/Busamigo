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
    private let guardSighting: String
    private(set) var voteRating: Int
    private(set) var author: User
    private(set) var sightingInformation: String = ""
    private(set) var location: CLLocationCoordinate2D
    private var timeOfSighting: String {
        let hours   = (Calendar.current.component(.hour, from: self.conceptionDate))
        let minutes = (Calendar.current.component(.minute, from: self.conceptionDate))
        
        return "\(hours):\(minutes)"
    }
    
    enum ValidationError: Error {
            case emptySighting
            case hasNumbers
        }
    
    //Location as a computed value?
    init(guardSighting: String, transportVehicle: String, author: User, location: CLLocationCoordinate2D) throws {
        guard !guardSighting.isEmpty else {
            throw ValidationError.emptySighting
        }
        let mySet = CharacterSet(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])

        guard transportVehicle.rangeOfCharacter(from: mySet) == nil else {
            throw ValidationError.hasNumbers
        }
        
        self.guardSighting = guardSighting
        self.transportVehicle = transportVehicle
        self.author = author
        self.voteRating = 0
        self.location = location
        self.conceptionDate = Date()
        self.sightingInformation = "\(guardSighting)" + ":" + "\(timeOfSighting)"
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
