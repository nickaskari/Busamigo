//
//  AddManager.swift
//  Busamigo
//
//  Created by Nick Askari on 26/05/2022.
//

import Foundation
import MapKit
import SwiftUI


//TODO: AuthorID is wrong

class PostingManager: ObservableObject {
    @Published private var manager = PostingInformation()
    private var creator = PostCreator()
    
    func getStop() -> Stop? {
        return manager.stop
    }
    
    func getSelectedStop() -> Stop? {
        return manager.selectedStop
    }
    
    func getStopLocation() -> CLLocationCoordinate2D? {
        return manager.stopLocation
    }
    
    func setStop(_ stop: Stop, location: CLLocationCoordinate2D) {
        manager.stop = stop
        manager.selectedStop = stop
        manager.stopLocation = location
    }
    
    func getRoute() -> Route? {
        return manager.route
    }
    
    func getSelectedRoute() -> Route? {
        return manager.selectedRoute
    }
    
    func setRoute(_ route: Route?) {
        manager.route = route
        manager.selectedRoute = route
    }
    
    func setFeedItem(description: String, userID: String) {
        creator.setFeedItem(getRoute(), getStop()!, author: userID, getStopLocation()!, 0, description: description)
    }
    
    func getFeedItem() -> Observation? {
        return creator.post
    }
    
    func getPreview() -> PreviewObservationView {
        return manager.getPreview()
    }
}
