//
//  Network.swift
//  Busamigo
//
//  Created by Nick Askari on 30/06/2022.
//

import Foundation
import Network

class Network: ObservableObject {
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    @Published private(set) var connected: Bool = true
    
    func checkConnection() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.connected = true
                }
            } else {
                DispatchQueue.main.async {
                    self.connected = false
                }
            }
        }
        monitor.start(queue: queue)
    }
}
