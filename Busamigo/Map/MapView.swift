//
//  MapView.swift
//  Busamigo
//
//  Created by Nick Askari on 10/02/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject private var feed: AtbFeed
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 63.446827, longitude: 10.421906), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    private var markers: Array<Marker>
    
    init(feed: AtbFeed) {
        self.feed = feed
        self.markers = []
        
        for item in feed.getFeed() {
            self.markers.append(Marker(location: MapMarker(coordinate: item.location)))
        }
    }
    
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: markers) { marker in
            marker.location
        }
            .scaledToFill()
            .edgesIgnoringSafeArea(.top)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(feed: AtbFeed())
    }
}
