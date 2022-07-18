//
//  Feed.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import Foundation
import CoreLocation
import Firebase
import SwiftUI

struct Feed {
    
    private(set) var visibleFeed: Array<Observation>
    private(set) var untouchedFeed: Array<Observation>
    private var incommingFeed: Array<Observation> = []
    
    private(set) var isShowingbar: Bool = true //Jesus dafuq

    init(_ inputFeed: Array<Observation>) {
        self.visibleFeed = inputFeed
        self.untouchedFeed = inputFeed
        self.standardFilter()
    }
    
    mutating func standardFilter() {
        reset()
        
        self.visibleFeed.sort {
            $0.getHotValue() > $1.getHotValue()
        }
    }
    
    mutating func recencyFilter() {
        reset()
        
        self.visibleFeed.sort {
            $0.getDate() > $1.getDate()
        }
    }
    
    mutating func ratingFilter() {
        reset()
        
        self.visibleFeed.sort {
            $0.voteScore > $1.voteScore
        }
    }
    
    mutating func tramFilter() {
        standardFilter()
        
        self.visibleFeed = visibleFeed.filter {
            $0.stop.vehicle == 900
        }
    }
    
    mutating func locationFilter(_ userLon: Double, _ userLat: Double) {
        reset()
        
        self.visibleFeed.sort {
            distance(lon1: $0.location.longitude, lat1: $0.location.latitude, lon2: userLon, lat2: userLat) <
                distance(lon1: $1.location.longitude, lat1: $1.location.latitude, lon2: userLon, lat2: userLat)
        }
       
    }
    
    func getObservationsForMap() -> [Observation] {
        var result: [Observation] = []
        var timeSorted = self.untouchedFeed
        timeSorted.sort {
            $0.getDate() > $1.getDate()
        }
        for obs in timeSorted {
            if !result.contains(where: {
                $0.stop.name == obs.stop.name
            }) {
                result.append(obs)
            }
        }
        return result
    }
    
    func getPositionInVisibleFeed(observation: Observation) -> Int {
        if let position = self.visibleFeed.firstIndex(of: observation) {
            return position + 1
        } else {
            return 0
        }
    }
    
    mutating func removeObservation(_ obs: Observation) {
        self.untouchedFeed = self.untouchedFeed.filter {
            $0 != obs
        }
        self.visibleFeed = self.visibleFeed.filter {
            $0 != obs
        }
    }
       
    mutating func initRefresh() {
        self.incommingFeed.removeAll()
    }
    
    mutating func appendToFeed(_ observation: Observation) {
        self.incommingFeed.append(observation)
    }
    
    mutating func commitRefresh() {
        self.untouchedFeed = self.incommingFeed
        self.visibleFeed = self.incommingFeed
    }
    
    mutating func upVote(_ old: Observation, userID: String, completion: @escaping(_ succsess: Bool) -> Void) {
        var new = old
        new.upVote()
        
        if let row = self.visibleFeed.firstIndex(where: {$0.id == old.id}) {
               visibleFeed[row] = new
        }
        if let row = self.untouchedFeed.firstIndex(where: {$0.id == old.id}) {
               untouchedFeed[row] = new
        }
        
        updateObservation(new.id, score: Int64(1), userID) { succsess in
            if succsess {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    mutating func downVote(_ old: Observation, userID: String, completion: @escaping(_ succsess: Bool) -> Void) {
        var new = old
        new.downVote()
        
        if let row = self.visibleFeed.firstIndex(where: {$0.id == old.id}) {
               visibleFeed[row] = new
        }
        if let row = self.untouchedFeed.firstIndex(where: {$0.id == old.id}) {
               untouchedFeed[row] = new
        }
        
        updateObservation(new.id, score: Int64(-1), userID) { succsess in
            if succsess {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func voteScoreFor(_ observation: Observation) -> Int {
        if let obs = self.untouchedFeed.firstIndex(where: {$0.id == observation.id}) {
            return untouchedFeed[obs].voteScore
        }
        return 0
    }
    
    func hasObservation(_ documentID: String) -> Bool {
        let res = self.untouchedFeed.filter {
            $0.id == documentID
        }
        if res.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    
    private func updateObservation(_ id: String?, score: Int64, _ userID: String, completion: @escaping(_ succsess: Bool) -> Void) {
        let db = Firestore.firestore()
        
        if let id = id {
            let docRef = db.collection("AtbFeed").document(id)
            let haveVotedRef = docRef.collection("HaveVoted")
            haveVotedRef.addDocument(data: [
                "id" : userID
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            
            docRef.updateData([
                "voteScore" : FieldValue.increment(score)
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
    
    private mutating func reset() {
        visibleFeed = untouchedFeed
    }

    /* docRef.setData(["name": restaurantName]) { error in
     if let error = error {
         print("Error writing document: \(error)")
     } else {
         print("Document successfully written!")
     }
 }*/
    
    
    //wtf bro, dårlig plassering
    
   mutating func hideBar() {
       self.isShowingbar = false
    }
    
    mutating func showBar() {
        self.isShowingbar = true
    }
    
}
