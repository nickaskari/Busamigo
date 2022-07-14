//
//  DataController.swift
//  Busamigo
//
//  Created by Nick Askari on 10/07/2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "BusamigoLog")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load log: \(error.localizedDescription)")
            }
        }
    }
}
