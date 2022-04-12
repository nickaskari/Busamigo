//
//  LocationManager.swift
//  Busamigo
//
//  Created by Nick Askari on 14/02/2022.
//

import Foundation
import CoreLocation
import CoreLocationUI
import ObjectiveC

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
}
