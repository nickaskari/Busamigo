//
//  ObservationManger.swift
//  Busamigo
//
//  Created by Nick Askari on 31/05/2022.
//

import Foundation
import SwiftUI
import MapKit

class ObservationManager: ObservableObject {
    
    @Published var mapObservation: Observation? {
        didSet {
            if let mapObservation = mapObservation {
                updateMapRegion(observation: mapObservation)
            }
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    var observationOpacity: Double = 1
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
    init() {
        self.mapObservation = nil
        self.mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 63.446827, longitude: 10.421906),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
    
    private func updateMapRegion(observation: Observation) {
        if mapRegion.span.latitudeDelta < mapSpan.latitudeDelta {
            withAnimation(.easeInOut) {
                mapRegion = MKCoordinateRegion(
                    center: observation.getCLLocationCoordinate2D(),
                    span: mapRegion.span)
            }
        } else {
            withAnimation(.easeInOut) {
                mapRegion = MKCoordinateRegion(
                    center: observation.getCLLocationCoordinate2D(),
                    span: mapSpan)
            }
        }
    }
    
    func showNextObservation(observation: Observation) {
        withAnimation(.easeInOut) {
            mapObservation = observation
        }
    }
    
    func showUserLocation(_ location: CLLocationCoordinate2D) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location,
                span: mapSpan)
        }
    }
}


