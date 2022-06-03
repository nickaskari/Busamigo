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
    
    func getSelectedStop() -> String? {
        return info.selectedStop
    }
    
    func getStopLocation() -> CLLocationCoordinate2D? {
        return info.stopLocation
    }
    
    func setStop(_ name: String, _ loc: CLLocationCoordinate2D) {
        info.stopName = name
        info.selectedStop = name
        info.stopLocation = loc
    }
    
    func getRoute() -> (Int, String)? {
        return info.route
    }
    
    func getSelectedRoute() -> (Int, String)? {
        info.selectedRoute
    }
    
    func setRoute(_ route: (Int, String)?) {
        info.route = route
        info.selectedRoute = route
    }
    
    func setFeedItem(description: String) {
        creator.setFeedItem(getRoute(), getStopName()!, transportVehicle: "bus", author: getUser()!, getStopLocation()!, 0, description: description)
    }
    
    func getFeedItem() -> FeedItem? {
        return creator.post
    }
    
    func getPreview() -> FeedItemView {
        return info.getPreview()
    }
}

struct PostingInformation {
    var stopName: String? = nil
    var stopLocation: CLLocationCoordinate2D? = nil
    var route: (Int, String)? = nil
    var post: FeedItem? = nil
    var selectedStop: String? = nil
    var selectedRoute: (Int, String)? = nil
    
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
        return FeedItemView(rating: 0, sighting: getSighting(), routeNr: self.route?.0)
    }
    
    private func getSighting() -> String {
        if route != nil {
            return "\(route?.1 ?? "")" + ";" + "\(stopName ?? "")" + ";" + getTimeOfSighting()
        } else {
            return "\(stopName ?? "")" + ";" + getTimeOfSighting()
        }
    }
}

struct PostCreator {
    var post: FeedItem? = nil
    
    mutating func setFeedItem(_ route: (Int, String)?, _ stop: String, transportVehicle: String, author: UUID, _ location: CLLocationCoordinate2D, _ voteScore: Int, description: String) {
        post = FeedItem(route: route, stop: stop, transportVehicle: transportVehicle, author: author, location: location, voteScore, description: description)
    }
}
