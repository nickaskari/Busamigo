//
//  LocationSorter.swift
//  Busamigo
//
//  Created by Nick Askari on 06/06/2022.
//

import Foundation
import MapKit

struct LocationSorter {
    private (set) var stops: Array<Stop> = []
    private (set) var stopAndDistance: Dictionary<Stop, Double> = [:]
    
    //used to find the 5 closest busstops from you. Returns the stops in addition to the distance from the user
    mutating func locationSort(_ loc: CLLocationCoordinate2D, _ dict: Dictionary<Stop, CLLocationCoordinate2D>) {
        var res1: [Stop] = Array(dict.keys)
        let lon = loc.longitude
        let lat = loc.latitude
        
        res1.sort {
            distance(lon1: dict[$0]!.longitude, lat1: dict[$0]!.latitude, lon2: lon, lat2: lat) <
                distance(lon1: dict[$1]!.longitude, lat1: dict[$1]!.latitude, lon2: lon, lat2: lat)
        }
        
        res1 =  Array(res1[0...4])
        var res2: Dictionary<Stop, Double> = [:]
        
        for stop in res1 {
            let dist = distance(lon1: dict[stop]!.longitude, lat1: dict[stop]!.latitude, lon2: lon, lat2: lat)
            res2[stop] = round(dist)
        }
        
        self.stops = res1
        self.stopAndDistance = res2
    }
}
