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
    
    func locationSort(_ loc: CLLocationCoordinate2D, _ dict: Dictionary<String, CLLocationCoordinate2D>) {
        self.sorter.locationSort(loc, dict)
    }
    
    func sortedStops() -> Array<String> {
        return self.sorter.stops
    }
    
    func sortedStopsAndDistances() -> Dictionary<String, Double> {
        return self.sorter.stopAndDistance
    }
}

struct LocationSorter {
    private (set) var stops: Array<String> = []
    private (set) var stopAndDistance: Dictionary<String, Double> = [:]
    
    //used to find the 5 closest busstops from you. Returns the stops in addition to the distance from the user
    mutating func locationSort(_ loc: CLLocationCoordinate2D, _ dict: Dictionary<String, CLLocationCoordinate2D>) {
        var res1: [String] = Array(dict.keys)
        let lon = loc.longitude
        let lat = loc.latitude
        
        res1.sort {
            distance(lon1: dict[$0]!.longitude, lat1: dict[$0]!.latitude, lon2: lon, lat2: lat) <
                distance(lon1: dict[$1]!.longitude, lat1: dict[$1]!.latitude, lon2: lon, lat2: lat)
        }
        
        res1 =  Array(res1[0...4])
        var res2: Dictionary<String, Double> = [:]
        
        for stop in res1 {
            let dist = distance(lon1: dict[stop]!.longitude, lat1: dict[stop]!.latitude, lon2: lon, lat2: lat)
            res2[stop] = round(dist)
        }
        
        self.stops = res1
        self.stopAndDistance = res2
    }
}
