//
//  LocationUtilites.swift
//  Busamigo
//
//  Created by Nick Askari on 26/05/2022.
//

import Foundation
import MapKit

class LocationUtilites: ObservableObject {
    private var sorter = LocationSorter()
    
    func locationSort(_ loc: CLLocationCoordinate2D, _ dict: Dictionary<Stop, CLLocationCoordinate2D>) {
        self.sorter.locationSort(loc, dict)
    }
    
    func sortedStops() -> Array<Stop> {
        return self.sorter.stops
    }
    
    func sortedStopsAndDistances() -> Dictionary<Stop, Double> {
        return self.sorter.stopAndDistance
    }
    
    func distanceForStop(_ stop: Stop) -> Double {
        if let distance = sorter.stopAndDistance[stop] {
            return distance
        } else {
            return 0
        }
    }
}
