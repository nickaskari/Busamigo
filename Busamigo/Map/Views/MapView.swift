//
//  MapView.swift
//  Busamigo
//
//  Created by Nick Askari on 10/02/2022.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct MapView: View {
    @ObservedObject private var feed: AtbFeed
    @ObservedObject private var locationManager: LocationManager
    @StateObject private var observationManager = ObservationManager()
    @EnvironmentObject private var tabvm: TabViewModel

    init(feed: AtbFeed, _ locationManager: LocationManager) {
        self.feed = feed
        self.locationManager = locationManager
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                Map(coordinateRegion: $observationManager.mapRegion, showsUserLocation: locationManager.showUserLocation, annotationItems: feed.getObservationForMap()) { post in
                    MapAnnotation(coordinate: post.getCLLocationCoordinate2D()) {
                        PostMapAnnotationView(post, observationManager)
                            .scaleEffect(observationManager.mapObservation == post ? 1 : 0.7)
                            .animation(.easeInOut, value: observationManager.mapObservation)
                            .onTapGesture {
                                observationManager.showNextObservation(observation: post)
                            }
                        
                    }
                }
                .accentColor(.blue)
                .frame(maxHeight: .infinity)
                .edgesIgnoringSafeArea(.top)
                
                MapToolsView(feed, locationManager, observationManager)
                
                if feed.newObservations == true {
                    withAnimation {
                        NewMapObservationView()
                    }
                }
            }
            
            if let obs = observationManager.mapObservation {
                withAnimation {
                    SlidingObservationView(observation: obs, observationManager)
                }
            }
        }
    }
}









struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(feed: AtbFeed(), LocationManager())
    }
}
