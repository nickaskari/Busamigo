//
//  FileManager.swift
//  Busamigo
//
//  Created by Nick Askari on 30/03/2022.
//

import Foundation
import MapKit

struct FileManager {
    
    //A dictionary of the stop names and lat/lon
    func getStops() -> Dictionary<String, CLLocationCoordinate2D> {
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
    
    //A sorted array of all the route numbers and route names
    func getRoutes() -> Array<(key: Int, value: String)> {
        var result: Dictionary<Int, String>  = [:]
        
        if let fileURL = Bundle.main.url(forResource: "routes", withExtension: "txt") {
         
            if let fileContents = try? String(contentsOf: fileURL) {
                var lines = fileContents.split(separator: "\n")
                lines.removeFirst()
                for line in lines {
                    let entry = line.split(separator: ",")
                    let routeNr: Int = Int(entry[2])!
                    let route: String = String(entry[3])
                    result[routeNr] = route
                }
            }
        }
        return result.sorted{ $0.key < $1.key }
    }
}

//Returns all routes assosiated with a stop
func getRoutesAssociatedWithStops() {
    //hmm
}
