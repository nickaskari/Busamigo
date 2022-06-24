//
//  FileManager.swift
//  Busamigo
//
//  Created by Nick Askari on 30/03/2022.
//

import Foundation
import MapKit

class FileManager {
    let stops = getStops()
    let routesAssociatedWithStops = getRoutesAssociatedWithStops()
    
    // A dictionary of the stop names and lat/lon
    static func getStops() -> Dictionary<Stop, CLLocationCoordinate2D> {
        var result: Dictionary<Stop, CLLocationCoordinate2D> = [:]
        
        if let fileURL = Bundle.main.url(forResource: "stops", withExtension: "txt") {
         
            if let fileContents = try? String(contentsOf: fileURL) {
                var lines = fileContents.split(separator: "\n")
                lines.removeFirst()
                for line in lines {
                    let entry = line.split(separator: ",")
                    let stopName: String = String(entry[0])
                    let lat = Double(entry[1])!
                    let lon = Double(entry[2])!
                    let vehicleType = Int(entry[3])!
                    let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    let stop = Stop(name: stopName, vehicle: vehicleType)
                    result[stop] = location
                }
            }
        }
        return result
    }
    
    
    // Returns all routes assosiated with a stop
    static func getRoutesAssociatedWithStops() -> Dictionary<Stop, [Route]> {
        var result: Dictionary<Stop, [Route]> = [:]
        
        if let fileURL = Bundle.main.url(forResource: "routes_for_stops", withExtension: "txt") {
            
            if let fileContents = try? String(contentsOf: fileURL) {
                var lines = fileContents.split(separator: "\n")
                lines.removeFirst()
                for line in lines {
                    let entry = line.split(separator: ",")
                    let stopName: String =  String(entry[0])
                    let vehicleType = Int(entry[1])!
                    let routeNr: Int = Int(entry[2])!
                    let routeName: String = String(entry[3])
                    
                    let stop = Stop(name: stopName, vehicle: vehicleType)
                    let route = Route(nr: routeNr, name: routeName)

                    if let before = result[stop] {
                        var after = before
                        after.append(route)
                        result[stop] = after
                    } else {
                        result[stop] = [route]
                    }
                }
            }
        }
        return result
    }
}
