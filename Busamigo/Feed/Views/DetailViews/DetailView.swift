//
//  DetailView.swift
//  Busamigo
//
//  Created by Nick Askari on 28/03/2022.
//

import SwiftUI
import MapKit

struct DetailView: View {
    private let feedItem: FeedItem
    private let locationManager: LocationManager
    @Environment(\.presentationMode) private var presentationMode
    
    init(feedItem: FeedItem, locationManager: LocationManager) {
        self.feedItem = feedItem
        self.locationManager = locationManager
    }
    
    var body: some View {
        VStack {
            DetailMapView(feedItem.location)
            DescriptionBubbleView(feedItem, locationManager)
                .padding()

        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.pink)
                        .font(.system(size: 20))
                        .padding(8)
                        .background(Capsule(style: .circular)
                            .foregroundColor(.white))
                        .shadow(radius: 1)
                })
            }
            ToolbarItem(placement: .principal) {
                Text("Beskrivelse")
                    .font(.headline)
                    .padding(8)
                    .background(Capsule(style: .circular)
                        .foregroundColor(.white))
                    .shadow(radius: 1)
            }
        }
    }
}












struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let item = FeedItem(route: (1, "ASDASD jalla"), stop: "Prinsens gate P1", author: UUID(), location: CLLocationCoordinate2D(latitude: 63.430230, longitude: 10.382971), 0, description: "GG")
        
        DetailView(feedItem: item, locationManager: LocationManager())
    }
}
