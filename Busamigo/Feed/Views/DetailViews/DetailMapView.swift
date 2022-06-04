//
//  DetailMapView.swift
//  Busamigo
//
//  Created by Nick Askari on 03/06/2022.
//

import SwiftUI
import MapKit

struct DetailMapView: View {
    private let location: CLLocationCoordinate2D
    private var markers: Array<Marker> {
        [Marker(location: MapMarker(coordinate: self.location))]
    }
    @State private var region: MKCoordinateRegion
    
    init(_ location: CLLocationCoordinate2D) {
        self.location = location
        region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: markers) { marker in
                marker.location
            }
        }
    }
}

