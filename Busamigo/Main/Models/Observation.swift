//
//  Observation.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import Foundation
import MapKit
import FirebaseFirestoreSwift
import Firebase
import FirebaseAuth


struct Observation: Identifiable, Hashable, Codable {
    
    @DocumentID var id: String?
    @ServerTimestamp private var observationDate: Timestamp?
    private(set) var searchInfo: String
    private(set) var voteScore: Int
    private(set) var author: String
    private var information: String
    private(set) var location: GeoPoint
    private(set) var description: String
    private(set) var route: Route?
    private(set) var stop: Stop
    
    init(route: Route?, stop: Stop, author: String, location: CLLocationCoordinate2D, voteScore: Int, description: String) {
        
        if route != nil {
            self.route = route
            self.searchInfo = "\(route?.name ?? "")" + "\(route?.nr ?? 0)" + "\(stop.name)"
            self.information = "\(route?.name ?? "")" + ";" + "\(stop.name)"
        } else {
            self.route = nil
            self.searchInfo = "\(stop.name)"
            self.information = "\(stop.name)"
        }
        
        self.stop = stop
        self.author = author
        self.voteScore = voteScore
        self.location = GeoPoint(latitude: location.latitude, longitude: location.longitude)
        self.description = description
    }
    
    func getCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
    
    func getDate() -> Date {
        return (observationDate?.dateValue()) ?? Date()
    }
    
    func getTimeOfobservation() -> String {
        return getTimeOfSighting(getDate())
    }
    
    func getHotValue() -> Double {
        return hot(voteScore, getDate())
    }
    
    func getInformation() -> String {
        return information + ";" + "\(getTimeOfobservation())"
    }
    
    mutating func upVote() {
        voteScore += 1
    }
    
    mutating func downVote() {
        voteScore -= 1
    }
    
    
    
    
    
    
    
    
    
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(voteScore)
    }
    
    static func == (lhs: Observation, rhs: Observation) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
}
