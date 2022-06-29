//
//  Stop.swift
//  Busamigo
//
//  Created by Nick Askari on 08/06/2022.
//

import Foundation

struct Stop: Hashable, Identifiable, Codable {
    var id: String
    let name: String
    let vehicle: Int
    
    init(name: String, vehicle: Int) {
        self.name = name
        self.vehicle = vehicle
        id = name + String(vehicle)
    }
}
