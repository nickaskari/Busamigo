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

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private var manager: CLLocationManager?
    private(set) var lastKnownLocation: CLLocationCoordinate2D?
    private(set) var errors: Dictionary<Int, String> = [1 : "", 2 : "", 3 : ""]
    var unableToGetLocation: Bool = false

    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            manager = CLLocationManager()
            manager!.delegate = self
            errors[1] = ""
        } else {
            let reason = "Du må skru på lokasjon i innstillinger. For å fikse dette dra til Innstillinger -> Personvern -> Stedstjenester."
            if errors[1] != nil {
                errors[1] = reason
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func displayLocationFilter(_ feed: AtbFeed) {
        updateLocationError(feed)
        
        if !hasError(feed) {
            if let loc = lastKnownLocation {
                feed.activateFilter("Lokasjon", userLon: loc.longitude, userLat: loc.latitude)
                unableToGetLocation = false
            }
            else {
                unableToGetLocation = true
            }
        }
    }
    
    private func hasError(_ feed: AtbFeed) -> Bool {
        return feed.getLocationError(errors) != nil
    }
    
    private func updateLocationError(_ feed: AtbFeed) {
        checkIfLocationServicesIsEnabled()
        
        if hasError(feed) {
            feed.alertLocationError()
         
        } else {
            feed.disableLocationError()
        }
    }

    private func updateLocation() {
        if let manager = manager {
            manager.startUpdatingLocation()
        }
    }
    
    private func checkLocationAuthorization() {
        guard let manager = manager else { return }

        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            let reason = "Begrenset tilgang på lokasjon. Mest sannsynlig på grunn av foreldrekontroll."
            if errors[3] != nil {
                errors[3] = reason
            }
        case .denied:
            let reason = "Du har ikke gitt Busamigo tilatelse til å bruke din lokasjon. For å fikse dette dra til Innstillinger -> Busamigo -> Sted."
            if errors[2] != nil {
                errors[2] = reason
            }
        case .authorizedAlways, .authorizedWhenInUse:
            updateLocation()
            flushErrors()
        @unknown default:
            flushErrors()
        }
        
    }
    
    private func flushErrors() {
        errors[1] = ""
        errors[2] = ""
        errors[3] = ""
    }
}
