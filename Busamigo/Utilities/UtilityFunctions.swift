//
//  UtilityFunctions.swift
//  Busamigo
//
//  Created by Nick Askari on 09/04/2022.
//

import Foundation
import CoreLocation

func distance(lat1: CLLocationDegrees, lat2: CLLocationDegrees, lon1: CLLocationDegrees, lon2: CLLocationDegrees) -> Double {
    let lon1: Double = lon1 * (Double.pi / 180)
    let lon2: Double = lon2 * (Double.pi / 180)
    let lat1: Double = lat1 * (Double.pi / 180)
    let lat2: Double = lat2 * (Double.pi / 180)
    
    // Haversine formula
    let dlon = lon2 - lon1
    let dlat = lat2 - lat1
    let a = pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2)
           
    let c = 2 * asin(sqrt(a))
    
    // Radius of earth in kilometers. Use 3956 for miles
    let r: Double = 6371
          
    // calculate the result
    return(c * r)
}
