//
//  RouteSearchView.swift
//  Busamigo
//
//  Created by Nick Askari on 27/03/2022.
//

import SwiftUI

struct RouteSearchView: View {
    @ObservedObject private var feed: FeedManager
    @ObservedObject private var postingManager: PostingManager
    @ObservedObject private var locationManager: LocationManager
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var searchText = ""

    init(_ feed: FeedManager, _ postingManager: PostingManager, _ locationManager: LocationManager) {
        self.feed = feed
        self.postingManager = postingManager
        self.locationManager = locationManager
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            List {
                if postingManager.getSelectedRoute() != nil && searchText == "" {
                    Section(header: Text("Ditt valg").font(.title2.bold()).foregroundColor(.black)
                        .padding(.bottom, 7)) {
                            RouteRowView(route: postingManager.getSelectedRoute()!, postingManager)
                        }
                }
                ForEach(filteredRoutes) { route in
                    RouteRowView(route: route, postingManager)
                }
            }
                .navigationBarBackButtonHidden(true)
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(.plain)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.pink)
                                .font(.system(size: 20))
                        })
                    }
                    
                    ToolbarItem(placement: ToolbarItemPlacement.principal) {
                        Text("Legg til buss/trikk")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if postingManager.getSelectedRoute() == nil {
                            NavigationLink(destination: {
                                PostObservationView(feed, locationManager, postingManager)
                            }, label: {
                                Text("Hopp over")
                                    .foregroundColor(.black)
                            })
                        }
                    }
                }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Søk buss/trikk")
            
            if postingManager.getSelectedRoute() != nil {
                NavigationLink(destination: {
                    PostObservationView(feed, locationManager, postingManager)
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
    
    var filteredRoutes: Array<Route> {
        let routes = feed.routes[postingManager.getStop()!]!
 
        if searchText.isEmpty {
            return []
        } else {
            return routes.filter {
                String($0.nr).localizedStandardContains(searchText) ||
                $0.name.localizedStandardContains(searchText)
            }
        }
    }
}















struct RouteSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RouteSearchView(FeedManager(), PostingManager(), LocationManager())
        }
    }
}
