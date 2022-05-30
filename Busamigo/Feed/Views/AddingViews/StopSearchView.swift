//
//  StopSearchView.swift
//  Busamigo
//
//  Created by Nick Askari on 27/03/2022.
//

import SwiftUI

struct StopSearchView: View {
    @State private var searchText = ""
    @ObservedObject var feed: AtbFeed
    @ObservedObject var locationManager: LocationManager
    @StateObject var postingManager = PostingManager()
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var popUpManager: PopUpManager
    @State var selected: String? = nil
    
    private let allStops = AtbFeed.stops
    var sorter: LocationUtilites = LocationUtilites()
    
    init(_ feed: AtbFeed, _ locationManager: LocationManager) {
        self.feed = feed
        self.locationManager = locationManager
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List {
                    if selected != nil && searchText.isEmpty {
                        Section(header: Text("Ditt valg").font(.title2.bold()).foregroundColor(.black)
                            .padding(.bottom, 7)) {
                                rowView(selected!, isPreview: true)
                            }
                    }
                    
                    if searchText.isEmpty && !closeStops.isEmpty {
                        Section(header: Text("I nærheten").font(.title2.bold()).foregroundColor(.black)
                            .padding(.bottom, 7)) {
                                ForEach(filteredStops, id: \.description) { stop in
                                    locationRowView(stop, sorter.sortedStopsAndDistances()[stop]!)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            withAnimation {
                                                selected = stop
                                                postingManager.setStopName(stop)
                                                postingManager.setStopLocation(allStops[stop]!)
                                            }
                                        }
                                        .listRowBackground(selected == stop ? Color.gray.opacity(0.25) : Color.clear)
                                        .animation(.none, value: selected)
                                }
                        }
                        .textCase(nil)
                    } else {
                        Section {
                            ForEach(filteredStops, id: \.description) { stop in
                                rowView(stop, isPreview: false)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        selected = stop
                                        postingManager.setStopName(stop)
                                        postingManager.setStopLocation(allStops[stop]!)
                                    }
                                    .listRowBackground(selected == stop ? Color.gray.opacity(0.25) : Color.clear)
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
                
                if selected != nil {
                    NavigationLink(isActive: $popUpManager.routeSearchIsActive, destination: {
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
                    .isDetailLink(false)
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
    
    private func rowView(_ stop: String, isPreview: Bool) -> some View {
        HStack {
            Image(systemName: "figure.wave")
                .font(.system(size: 20))
                .foregroundColor(.black)
                .padding(.horizontal, 7)
            Text(stop)
                .font(.headline)
                .foregroundColor(.black)
            Spacer()
            if selected == stop && !isPreview {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .padding(.horizontal, 7)
            }
        }
        .padding(.bottom, 6)
        .padding(.top, 6)
    }
    
    private func locationRowView(_ stop: String, _ distance: Double) -> some View {
        HStack {
            Image(systemName: "figure.wave")
                .font(.system(size: 20))
                .foregroundColor(.black)
                .padding(.horizontal, 7)
            VStack(alignment: .leading) {
                Text(stop)
                    .font(.headline)
                    .foregroundColor(.black)
                HStack {
                    Text("\(distance)" + " m")
                        .foregroundColor(.pink)
                    .font(.subheadline)
                    Image(systemName: "location.fill")
                        .foregroundColor(.pink)
                        .font(.system(size: 10))
                }
            }
            Spacer()
            if selected == stop {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .padding(.horizontal, 7)
            }
        }
        .padding(.bottom, 6)
        .padding(.top, 6)
    }
}

struct StopsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StopSearchView(AtbFeed(), LocationManager())
        }
    }
}
