//
//  AtbFeed.swift
//  Busamigo
//
//  Created by Nick Askari on 17/02/2022.
//

import Foundation
import CoreLocation

class AtbFeed: ObservableObject {
    
    static let fileManager = FileManager()
    
    static let routes: Array<String> = fileManager.getRoutes()
    static let stops: Dictionary<String, String> = fileManager.getStops()
    
    //TRIAL FEEDITEMS
    
  
}
