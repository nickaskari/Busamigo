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
    let tramStops = getTramStops()
    let routesAssociatedWithStops = getRoutesAssociatedWithStops()
    
    // A dictionary of the stop names and lat/lon
    static func getStops() -> Dictionary<String, CLLocationCoordinate2D> {
        var result: Dictionary<String, CLLocationCoordinate2D> = [:]
        
        if let fileURL = Bundle.main.url(forResource: "stops", withExtension: "txt") {
         
            if let fileContents = try? String(contentsOf: fileURL) {
                var lines = fileContents.split(separator: "\n")
                lines.removeFirst()
                for line in lines {
                    let entry = line.split(separator: ",")
                    let stopName: String = String(entry[1])
                    let lat = Double(entry[2])!
                    let lon = Double(entry[3])!
                    let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    result[stopName] = location
                }
            }
        }
        return result
    }
    
    // Returns all tram stops
    static func getTramStops() -> [String] {
        var result: [String] = []
        
        if let fileURL = Bundle.main.url(forResource: "tram_stops", withExtension: "txt") {
            
            if let fileContents = try? String(contentsOf: fileURL) {
                let lines = fileContents.split(separator: "\n")
                for line in lines {
                    let stopName: String = String(line)
                    result.append(stopName)
                }
            }
        }
        return result
    }
    
    // Returns all routes assosiated with a stop
    static func getRoutesAssociatedWithStops() -> Dictionary<String, [(id: String, nr: Int, name: String)]> {
        var result: Dictionary<String, [(String, Int, String)]> = [:]
        
        if let fileURL = Bundle.main.url(forResource: "routes_for_stops", withExtension: "txt") {
            
            if let fileContents = try? String(contentsOf: fileURL) {
                var lines = fileContents.split(separator: "\n")
                lines.removeFirst()
                for line in lines {
                    let entry = line.split(separator: ",")
                    let stop: String =  String(entry[0])
                    let routeNr: Int = Int(entry[1])!
                    let routeName: String = String(entry[2])
                    let id: String = String(entry[1] + routeName)
                    
                    if let before = result[stop] {
                        var after = before
                        after.append((id, routeNr, routeName))
                        result[stop] = after
                    } else {
                        result[stop] = [(id, routeNr, routeName)]
                    }
                }
            }
        }
        
        return result
    }
}

