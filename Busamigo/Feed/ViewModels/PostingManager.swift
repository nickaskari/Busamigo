//
//  AddManager.swift
//  Busamigo
//
//  Created by Nick Askari on 26/05/2022.
//

import Foundation
import MapKit
import SwiftUI

class PostingManager: ObservableObject {
    @Published private var info = PostingInformation()
    private var creator = PostCreator()
    
    func getStopName() -> String? {
        return info.stopName
    }
    
    func setStopName(_ name: String) {
        info.stopName = name
    }
    
    func getStopLocation() -> CLLocationCoordinate2D? {
        return info.stopLocation
    }
    
    func setStopLocation(_ loc: CLLocationCoordinate2D) {
        return info.stopLocation = loc
    }
    
    func getRoute() -> String? {
        return info.route
    }
    
    func setRoute(_ route: String?) {
        info.route = route
    }
    
    func setFeedItem() {
        creator.setFeedItem(getRoute(), getStopName()!, transportVehicle: "bus", author: getUser()!, getStopLocation()!, 0)
    }
    
    func getFeedItem() -> FeedItem? {
        return creator.post
    }
    
    func getPreview() -> FeedItemView {
        return info.getPreview()
    }
    
    func addDescription(_ description: String) {
        return creator.addDescription(description)
    }
}

struct PostingInformation {
    var stopName: String? = nil
    var stopLocation: CLLocationCoordinate2D? = nil
    var route: String? = nil
    var post: FeedItem? = nil
    
    func canPost() -> Bool {
        if stopName != nil && stopLocation != nil && route != nil {
            return true
        }
        if stopName != nil && stopLocation != nil && route == nil {
            return true
        }
        return false
    }
    
    func getPreview() -> FeedItemView {
        return FeedItemView(rating: 0, sighting: getSighting(), vehicle: "bus")
    }
    
    private func getSighting() -> String {
        if route != nil {
            return "\(route ?? "")" + ";" + "\(stopName ?? "")" + ";" + getTimeOfSighting()
        } else {
            return "\(stopName ?? "")" + ";" + getTimeOfSighting()
        }
    }
}

struct PostCreator {
    var post: FeedItem? = nil
    
    mutating func setFeedItem(_ route: String?, _ stop: String, transportVehicle: String, author: UUID, _ location: CLLocationCoordinate2D, _ voteScore: Int) {
        post = FeedItem(route: route, stop: stop, transportVehicle: transportVehicle, author: author, location: location, voteScore)
    }
    
    mutating func addDescription(_ description: String) {
        if post != nil {
            post!.addDescription(description)
        }
    }
}
