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
    @ObservedObject private var feed: FeedManager
    @ObservedObject private var locationManager: LocationManager
    @StateObject private var observationManager = ObservationManager()
    @EnvironmentObject private var tabvm: TabViewModel
    @EnvironmentObject private var network: Network

    init(feed: FeedManager, _ locationManager: LocationManager) {
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
                .frame(maxHeight: .infinity)
                .edgesIgnoringSafeArea(.top)
                
                MapToolsView(feed, locationManager, observationManager)
                
                if feed.status == .newObservations {
                        NewMapObservationView()
                } else if feed.status != .none {
                        StatusView()
                    }
            }
            
            if let obs = observationManager.mapObservation {
                withAnimation {
                    SlidingObservationView(observation: obs, observationManager)
                }
            }
        }
        .onAppear {
            network.checkConnection()
            if !network.connected {
                feed.status = .networkError
            }
        }
    }
}









struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(feed: FeedManager(), LocationManager())
    }
}
