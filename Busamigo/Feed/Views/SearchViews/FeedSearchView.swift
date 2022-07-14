//
//  FeedSearchView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import SwiftUI

struct FeedSearchView: View {
    @ObservedObject var feed: AtbFeed
    @ObservedObject var locationManager: LocationManager
    @State private var searchText = ""
    
    @Environment(\.presentationMode) private var presentationMode
    
    init (_ feed: AtbFeed, _ locationManager: LocationManager) {
        self.feed = feed
        self.locationManager = locationManager
    }
    
    var body: some View {
        ListFeedView(filteredFeed, locationManager)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Søk buss/trikk eller holdeplasser")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    backButton
                }
                
                ToolbarItem(placement: .principal) {
                    header
                }
            }
    }
    
    private var filteredFeed: [Observation] {
        if searchText.isEmpty {
            return []
        } else {
            return feed.getUntouchedFeed().filter { $0.searchInfo.localizedStandardContains(searchText) }
        }
    }
    
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.pink)
                .font(.system(size: 20))
        })
    }
    
    private var header: some View {
        Text("Søk i feed")
            .font(.headline)
    }
}








struct FeedSearchView_Previews: PreviewProvider {
    static var previews: some View {
        FeedSearchView(AtbFeed(), LocationManager())
    }
}
