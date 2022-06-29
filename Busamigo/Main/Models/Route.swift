//
//  Route.swift
//  Busamigo
//
//  Created by Nick Askari on 08/06/2022.
//

import Foundation

struct Route: Hashable, Identifiable, Codable {
    var id: String
    let nr: Int
    let name: String
    
    init(nr: Int, name: String) {
        self.name = name
        self.nr = nr
        id = name + String(nr)
    }
}
