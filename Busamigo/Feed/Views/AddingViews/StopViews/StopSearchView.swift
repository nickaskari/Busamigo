//
//  StopSearchView.swift
//  Busamigo
//
//  Created by Nick Askari on 27/03/2022.
//

import SwiftUI
import MapKit

struct StopSearchView: View {
    @ObservedObject private var feed: AtbFeed
    @ObservedObject private var locationManager: LocationManager
    @StateObject private var postingManager = PostingManager()
    @Environment(\.presentationMode) private var presentationMode
    
    private let allStops: Dictionary<String, CLLocationCoordinate2D>
    @State private var searchText = ""
    @StateObject private var sorter: LocationUtilites = LocationUtilites()
    
    init(_ feed: AtbFeed, _ locationManager: LocationManager) {
        self.feed = feed
        self.locationManager = locationManager
        self.allStops = feed.stops
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List {
                    if postingManager.getSelectedStop() != nil && searchText.isEmpty {
                        StopChoiceSectionView(postingManager)
                    }
                    
                    if searchText.isEmpty && !closeStops.isEmpty {
                        Section(header: Text("I nærheten").font(.title2.bold()).foregroundColor(.black)
                            .padding(.bottom, 7)) {
                                ForEach(filteredStops, id: \.description) { stop in
                                    StopLocationRowView(stop, distance: sorter.sortedStopsAndDistances()[stop]!, postingManager)
                                    .onTapGesture {
                                        withAnimation {
                                            postingManager.setStop(stop, allStops[stop]!)
                                        }
                                        postingManager.setRoute(nil)
                                    }
                                }
                        }
                        
                    } else {
                        Section {
                            ForEach(filteredStops, id: \.description) { stop in
                                StopRowView(stop, isPreview: false, postingManager)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        postingManager.setStop(stop, allStops[stop]!)
                                        postingManager.setRoute(nil)
                                    }
                                    .listRowBackground(postingManager.getSelectedStop() == stop ? Color.gray.opacity(0.25) : Color.clear)
                            }
                        }
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Søk holdeplasser")
                .listStyle(.plain)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.pink)
                                .font(.system(size: 20))
                        })
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Text("Legg til holdeplass")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }

                .navigationBarTitle("")
                .navigationBarTitleDisplayMode(.inline)
                
                if postingManager.getSelectedStop() != nil {
                    NavigationLink(destination: {
                        RouteSearchView(feed, postingManager, locationManager)
                    }, label: {
                        Text("Neste")
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding()
                            .background(Capsule(style: .circular)
                                            .foregroundColor(.black))
                            .padding(.bottom)
                    })
                }
            }
        }
        .navigationBarHidden(true)
        .accentColor(.pink)
    }
    
    private var filteredStops: [String] {
        let stops = Array(allStops.keys)
        
        if searchText.isEmpty {
            return closeStops
        } else {
            return stops.filter { $0.localizedStandardContains(searchText) }
        }
    }
    
    private var closeStops: [String] {
        let stops = allStops
        let location = locationManager.lastKnownLocation
    
        if let location = location {
            sorter.locationSort(location, stops)
            return sorter.sortedStops()
        }
        return []
    }
}









struct StopsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StopSearchView(AtbFeed(), LocationManager())
        }
    }
}
