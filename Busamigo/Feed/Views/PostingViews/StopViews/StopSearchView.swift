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
    private var locationManager: LocationManager
    @StateObject private var postingManager = PostingManager()
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var searchText = ""
    private var sorter: LocationUtilites = LocationUtilites()
    
    init(_ feed: AtbFeed, _ locationManager: LocationManager) {
        self.feed = feed
        self.locationManager = locationManager
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
                                ForEach(filteredStops) { stop in
                                    StopLocationRowView(stop, distance: sorter.distanceForStop(stop), postingManager)
                                    .onTapGesture {
                                        withAnimation {
                                            postingManager.setStop(stop, location: feed.stops[stop]!)
                                        }
                                        postingManager.setRoute(nil)
                                    }
                                }
                        }
                        
                    } else {
                        Section {
                            ForEach(filteredStops) { stop in
                                StopRowView(stop, isPreview: false, postingManager)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        postingManager.setStop(stop, location: feed.stops[stop]!)
                                        postingManager.setRoute(nil)
                                    }
                                    .listRowBackground(postingManager.getSelectedStop() == stop ? Color.gray.opacity(0.25) : Color.clear)
                            }
                        }
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Søk holdeplasser")
                .listStyle(.plain)
                .toolbar { ToolbarItem(placement: .navigationBarLeading) {
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
                            .nextButtonStyle()
                    })
                }
            }
        }
        .navigationBarHidden(true)
        .accentColor(.pink)
    }
    
    private var filteredStops: [Stop] {
        let stops = Array(feed.stops.keys)
        
        if searchText.isEmpty {
            return closeStops
        } else {
            return stops.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    private var closeStops: [Stop] {
        let location = locationManager.lastKnownLocation
    
        if let location = location {
            sorter.locationSort(location, feed.stops)
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
