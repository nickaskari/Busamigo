//
//  UtilityFunctions.swift
//  Busamigo
//
//  Created by Nick Askari on 09/04/2022.
//

import Foundation
import CoreLocation
import SwiftUI
import Firebase

func distance(lon1: CLLocationDegrees, lat1: CLLocationDegrees, lon2: CLLocationDegrees, lat2: CLLocationDegrees) -> Double {
    let lon1: Double = lon1 * (Double.pi / 180)
    let lon2: Double = lon2 * (Double.pi / 180)
    let lat1: Double = lat1 * (Double.pi / 180)
    let lat2: Double = lat2 * (Double.pi / 180)
    
    // Haversine formula
    let dlon = lon2 - lon1
    let dlat = lat2 - lat1
    let a = pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2)
           
    let c = 2 * asin(sqrt(a))
    
    // Radius of earth in meters
    let r: Double = 6371000
          
    // calculate the result
    let result: Double = c * r
    return result
}

func getTapticFeedBack(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    let impact = UIImpactFeedbackGenerator(style: style)
    impact.impactOccurred()
}

func createSightingDict(_ sighting: String) -> Dictionary<String, Double> {
    var opacityValue: Double = 1.0
    var dict: Dictionary<String, Double> = [ : ]
    for info in sighting.components(separatedBy: ";") {
        dict[info] = opacityValue
        opacityValue -= 0.2
    }
    return dict
}

func portraitOrientationLock() {
    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    AppDelegate.orientationLock = .portrait
}

func getTimeOfSighting(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.string(from: date)
}

//Returns time since now in a string format, and also a value for opacity. The more recent the date, the more opacity is attained.
func getTimeFromNow(date: Date) -> (String, Double) {
    let dif = round(abs(date.timeIntervalSinceNow))
    
    switch dif {
    case 0..<60:
        return ("nå", 1.0)
    case 60..<1800:
        let res = Int(dif) / 60
        return ("\(res)" + " min siden", 1.0)
    case 1800..<3600:
        let res = Int(dif) / 60
        return ("\(res)" + " min siden",  0.7)
    case 3600..<7200:
        let res = Int(dif) / 3600
        return ("\(res)" + " time siden", 0.4)
    default:
        let res = Int(dif) / 3600
        return ("\(res)" + " timer siden", 0.4)
    }
}

func busOrTram(_ stop: Stop) -> String {
    switch stop.vehicle {
    case 700:
        return "bus"
    case 900:
        return "tram"
    default:
        return "figure.wave"
    }
}


