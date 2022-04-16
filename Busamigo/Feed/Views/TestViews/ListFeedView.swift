//
//  ListFeedView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import SwiftUI
import UIKit

struct ListFeedView: View {
    @ObservedObject var feed = AtbFeed()

        var body: some View {
            NavigationView {
                List(feed.getFeed()) { item in
                    
                    ZStack {
                        NavigationLink(destination: {
                            DetailView(description: item.sightingInformation, location: item.location)
                        }, label: {})
                            .opacity(0)
                        
                        FeedItemView(rating: item.voteScore, sighting: item.sightingInformation, vehicle: item.transportVehicle)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .padding(.bottom)
                }
                .listStyle(.plain)
                .refreshable {
                    feed.activateFilter("Buss", userLon: nil, userLat: nil)
                }
                .navigationTitle("List feed test")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            getTapticFeedBack(style: .light)
                            feed.activateFilter("Relevant", userLon: nil, userLat: nil)
                        }, label: {
                            Image(systemName: "arrow.uturn.forward.circle.fill")
                                .foregroundColor(.pink)
                                .font(.system(size: 25))
                        })
                        .buttonStyle(PushDownButtonStyle())
                    }
                }
            }
            .accentColor(.pink)

        }
}






struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        ListFeedView()
    }
}
