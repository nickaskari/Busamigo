//
//  RouteSearchView.swift
//  Busamigo
//
//  Created by Nick Askari on 27/03/2022.
//

import SwiftUI

struct RouteSearchView: View {
    @State private var searchText = ""
    @ObservedObject var feed: AtbFeed
    @ObservedObject var postingManager: PostingManager
    @ObservedObject var locationManager: LocationManager
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var popUpManager: PopUpManager
    @State var selected: (Int, String)? = nil
    
    init(_ feed: AtbFeed, _ postingManager: PostingManager, _ locationManager: LocationManager) {
        self.feed = feed
        self.postingManager = postingManager
        self.locationManager = locationManager
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            List {
                if selected != nil && searchText == "" {
                    Section(header: Text("Ditt valg").font(.title2.bold()).foregroundColor(.black)
                        .padding(.bottom, 7)) {
                            getRowView(selected!.0, selected!.1)
                        }
                        .textCase(nil)
                }
                ForEach(filteredRoutes, id: \.key) { route in
                    getRowView(route.key, route.value)
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
                        if selected == nil {
                            NavigationLink(isActive: $popUpManager.skipToAddIsActive, destination: {
                                AddFeedItemView(feed, locationManager, postingManager)
                            }, label: {
                                Text("Hopp over")
                                    .foregroundColor(.black)
                            })
                            .isDetailLink(false)
                        }
                    }
                }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Søk buss/trikk")
            
            if selected != nil {
                NavigationLink(isActive: $popUpManager.addFeedItemIsActive, destination: {
                    AddFeedItemView(feed, locationManager, postingManager)
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
    
    var filteredRoutes: Array<(key: Int, value: String)> {
        let routes = AtbFeed.routes
 
        if searchText.isEmpty {
            return []
        } else {
            return routes.filter {
                String($0.key).localizedStandardContains(searchText) ||
                $0.value.localizedStandardContains(searchText)
            }
        }
    }
    
    private func getRowView(_ num: Int, _ name: String) -> some View {
        HStack {
            Text("\(num)")
                .foregroundColor(.pink)
                .font(.title3)
                .frame(width: 55)
            Text("\(name)")
                .font(.headline)
                .foregroundColor(.black)
            Spacer()
            if selected?.0 == num && selected?.1 == name {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .padding(.horizontal, 7)
            }
        }
        .padding(.bottom, 6)
        .padding(.top, 6)
        .contentShape(Rectangle())
        .onTapGesture {
            if selected ?? (-1, "") != (num, name) {
                selected = (num, name)
                postingManager.setRoute(name)
            } else {
                withAnimation {
                    selected = nil
                    postingManager.setRoute(nil)
                }
            }
        }
        .listRowBackground((selected?.0 == num && selected?.1 == name)  ? Color.gray.opacity(0.25) : Color.clear)
    }
}















struct RouteSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RouteSearchView(AtbFeed(), PostingManager(), LocationManager())
        }
    }
}
