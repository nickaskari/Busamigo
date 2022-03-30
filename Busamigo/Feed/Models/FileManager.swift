//
//  FileManager.swift
//  Busamigo
//
//  Created by Nick Askari on 30/03/2022.
//

import Foundation

struct FileManager {
    
    //An array of all the routes
    func getRoutes() -> Array<String> {
        var result: Array<String> = []
        
        if let fileURL = Bundle.main.url(forResource: "routes", withExtension: "txt") {
         
            if let fileContents = try? String(contentsOf: fileURL) {
                var lines = fileContents.split(separator: "\n")
                lines.removeFirst()
                for line in lines {
                    let entry = line.split(separator: ",")
                    let route: String = String(entry[2] + " " + entry[3].description)
                    result.append(route)
                }
            }
        }
        return result
    }
    
    //A dictionary of the stop names and lat/lon
    func getStops() -> Dictionary<String, String> {
        var result: Dictionary<String, String> = [:]
        
        if let fileURL = Bundle.main.url(forResource: "stops", withExtension: "txt") {
         
            if let fileContents = try? String(contentsOf: fileURL) {
                var lines = fileContents.split(separator: "\n")
                lines.removeFirst()
                for line in lines {
                    let entry = line.split(separator: ",")
                    let stopName: String = String(entry[1])
                    let location: String = String(entry[2] + ":" + entry[3])
                    result[stopName] = location
                }
            }
        }
        return result
    }
}
