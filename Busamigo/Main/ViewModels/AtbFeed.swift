//
//  AtbFeed.swift
//  Busamigo
//
//  Created by Nick Askari on 17/02/2022.
//

import Foundation
import MapKit
import Firebase
import SwiftUI

class AtbFeed: ObservableObject {
    
    static let allFilteres = ["Relevant", "Nylig", "Lokasjon", "Rating", "Trikk"]
    
    let stops: Dictionary<Stop, CLLocationCoordinate2D> = FileManager().stops
    let routes: Dictionary<Stop, [Route]> = FileManager().routesAssociatedWithStops
    let area = Area(upperLat: 63.462133, downerLat: 63.302000, leftLon: 10.051845, rightLon: 10.676401)
    
    private let db = Firestore.firestore()
    
    private static func createFilters() -> Filters {
        Filters(allFilteres)
    }
    
    @Published private var atbFeed: Feed = Feed([])
    @Published private var atbFilters: Filters = createFilters()
    @Published private var locationErrors: LocationErrors = LocationErrors()
    @Published private var firebaseListener: ListenerRegistration?
    @Published var networkError: Bool = false
    @Published var newObservations: Bool = false
    
    func fetchFeed(completion: @escaping(_ success: Bool) -> Void) {
        self.atbFeed.initRefresh()

        let ref = db.collection("AtbFeed")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(false)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    do {
                        let observation: Observation = try document.data(as: Observation.self)
                        self.atbFeed.appendToFeed(observation)
                    } catch {
                        print(error.localizedDescription)
                        completion(false)
                    }
                }
                self.atbFeed.commitRefresh()
                self.newObservations = false
                completion(true)
            }
        }
    }
    
    func listenForUpdates() {
        db.collection("AtbFeed").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                self.networkError = true
                return
            }
            
            if !documents.isEmpty {
                for document in documents {
                    if !self.atbFeed.hasObservation(document.documentID) {
                        self.newObservations = true
                        break
                    }
                }
            }
        }
    }
    
    func removeFirebaseListener() {
        self.firebaseListener?.remove()
    }
    
    func postToFeed(_ post: Observation, completion: @escaping(_ success: Bool) -> Void) {
        let ref = db.collection("AtbFeed")
        canPost(stopName: post.stop.name) { able in
            if able {
                do {
                    let newPost = try ref.addDocument(from: post)
                    print("Post is sent to feed: \(newPost.documentID)")
                    completion(true)
                } catch {
                    print(error.localizedDescription)
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    
    /* Some "ERRORS" for spamcheck()
     if current user is somehow not found -> not spam
     if there is an error -> not spam
     */
    
    func spamCheck(completion: @escaping(_ spam: Bool) -> Void) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let ref = db.collection("AtbFeed").whereField("author", isEqualTo: uid)
        
        ref.getDocuments { snpashot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(false)
                return
            }
            
            if let snapshot = snpashot {
                if snapshot.count > 2 {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    func upVoteObservation(_ obs: Observation, completion: @escaping(_ success: Bool) -> Void) {
        if Auth.auth().currentUser != nil {
            let uid = Auth.auth().currentUser?.uid ?? ""

            canVote(obs, userID: uid) { able in
                if able {
                    self.atbFeed.upVote(obs, userID: uid) { succsess in
                        if succsess {
                            completion(true)
                        } else {
                            self.networkError = true
                            completion(false)
                        }
                    }
                } else {
                    completion(false)
                }
            }
        } else {
            completion(false)
        }
    }
    
    func downVoteObservation(_ obs: Observation, completion: @escaping(_ success: Bool) -> Void) {
        if Auth.auth().currentUser != nil {
            let uid = Auth.auth().currentUser?.uid ?? ""

            canVote(obs, userID: uid) { able in
                if able {
                    self.atbFeed.downVote(obs, userID: uid) { succsess in
                        if succsess {
                            completion(true)
                        } else {
                            self.networkError = true
                            completion(false)
                        }
                    }
                } else {
                    completion(false)
                }
            }
        } else {
            completion(false)
        }
    }
    
    func flagObservation(docID: String, _ reason: String, completion: @escaping(_ success: Bool) -> Void) {
        let ref = db.collection("Flagged")
        
        ref.addDocument(data: [
            "docID" : docID,
            "reason" : reason
        ], completion: { error in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        })
    }
    
    func voteScoreFor(observation: Observation) -> Int {
        return atbFeed.voteScoreFor(observation)
    }
    
    func getPositionInVisibleFeed(observation: Observation) -> Int {
        return atbFeed.getPositionInVisibleFeed(observation: observation)
    }
    
    func getVisibleFeed() -> Array<Observation> {
        return atbFeed.visibleFeed
    }
    
    func getUntouchedFeed() -> Array<Observation> {
        return atbFeed.untouchedFeed
    }
    
    func getObservationForMap() -> Array<Observation> {
        return atbFeed.getObservationsForMap()
    }
    
    func removeObservation(_ obs: Observation) {
        atbFeed.removeObservation(obs)
    }
    
    func activateFilter(_ filter: String, userLon: Double?, userLat: Double?) {
        switch filter {
        case "Relevant":
            atbFeed.standardFilter()
            atbFilters.activateFilter(filter)
        case "Trikk":
            atbFeed.tramFilter()
            atbFilters.activateFilter(filter)
        case "Rating":
            atbFeed.ratingFilter()
            atbFilters.activateFilter(filter)
        case "Lokasjon":
            atbFeed.locationFilter(userLon!, userLat!)
            atbFilters.activateFilter(filter)
        case "Nylig":
            atbFeed.recencyFilter()
            atbFilters.activateFilter(filter)
        default:
            print("Something is not right: activateFilter in AtbFeed")
        }
    }
    
    func getFilters() -> Array<String> {
        return atbFilters.allFilters
    }
    
    func isFilterOn(_ filter: String) -> Bool {
        return atbFilters.isFilterOn(filter)
    }
    
    func alertLocationError() {
        locationErrors.alertError()
        atbFilters.activateFilter("Lokasjon")
    }
    
    func disableLocationError() {
        locationErrors.disableError()
    }
    
    func getLocationError(_ errorDict: Dictionary<Int, String>) -> (Int, String)? {
        locationErrors.errorPicker(errorDict)
    }
    
    func isLocationError() -> Bool {
        return locationErrors.showError
    }
    
    func isShowingBar() -> Bool {
        return atbFeed.isShowingbar
    }
    
    func hideBar() {
        return atbFeed.hideBar()
    }
    
    func showBar() {
        return atbFeed.showBar()
    }
    
    private func canVote(_ obs: Observation, userID: String, completion: @escaping(_ able: Bool) -> Void) {
        
        if Auth.auth().currentUser != nil {
            let ref = db.collection("AtbFeed")
                .document(obs.id ?? "")
                .collection("HaveVoted")
            
            ref.getDocuments { snapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    completion(false)
                    return
                }
                
                if let snapshot = snapshot {
                    var containsUser = false
                    
                    for document in snapshot.documents {
                        let data = document.data()
                        let userHaveVoted = data["id"] as? String ?? ""
                        if userID == userHaveVoted {
                            containsUser = true
                            break
                        }
                    }
                    if containsUser {
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
            }
        }
    }
    
    private func canPost(stopName: String, completion: @escaping(_ able: Bool) -> Void) {
        let ref = db.collection("AtbFeed").whereField("stop.name", isEqualTo: stopName)
        
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(false)
                return
            }
            
            if let snapshot = snapshot {
                if snapshot.isEmpty {
                    completion(true)
                } else {
                    for document in snapshot.documents {
                        let data = document.data()
                        if let observationDate = (data["observationDate"] as? Timestamp)?.dateValue() {
                            if self.isTooRecent(observationDate) {
                                completion(false)
                            } else {
                                completion(true)
                                break
                            }
                        } else {
                            completion(false)
                        }
                    }
                }
            }
        }
    }
    
    private func isTooRecent(_ date: Date) -> Bool {
        let dif = abs(date.timeIntervalSinceNow)
        let limit: Double = 60 * 20
        return dif <= limit
    }
}
