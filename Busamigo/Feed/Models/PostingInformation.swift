//
//  PostingInformation.swift
//  Busamigo
//
//  Created by Nick Askari on 06/06/2022.
//

import Foundation
import MapKit

struct PostingInformation {
    var stop: Stop? = nil
    var stopLocation: CLLocationCoordinate2D? = nil
    var route: Route? = nil
    var selectedStop: Stop? = nil
    var selectedRoute: Route? = nil
    var post: Observation? = nil
    
    func getPreview() -> PreviewObservationView {
        let obs = Observation(route: route, stop: stop!, author: "someID", location: stopLocation!, voteScore: 0, description: "")
        return PreviewObservationView(observation: obs)
    }
    
}
