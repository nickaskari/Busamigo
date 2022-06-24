//
//  PostCreator.swift
//  Busamigo
//
//  Created by Nick Askari on 06/06/2022.
//

import Foundation
import MapKit

struct PostCreator {
    var post: Observation? = nil
    
    mutating func setFeedItem(_ route: Route?, _ stop: Stop, author: String, _ location: CLLocationCoordinate2D, _ voteScore: Int, description: String) {
        post = Observation(route: route, stop: stop, author: author, location: location, voteScore: voteScore, description: description)
    }
}
