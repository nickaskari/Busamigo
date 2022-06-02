//
//  DetailView.swift
//  Busamigo
//
//  Created by Nick Askari on 28/03/2022.
//

import SwiftUI
import MapKit

struct DetailView: View {
    var feedItem: FeedItem
    @ObservedObject var locationManager: LocationManager
    let sightingDict: Dictionary<String, Double>
    @Environment(\.presentationMode) var presentationMode
    
    init(feedItem: FeedItem, locationManager: LocationManager) {
        self.feedItem = feedItem
        self.locationManager = locationManager
        self.sightingDict = createSightingDict(feedItem.sightingInformation)
    }
    
    var body: some View {
        VStack {
            DetailMapView(feedItem.location)
            descriptionBubble
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
    
    private var descriptionBubble: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .opacity(0.0)
            VStack(alignment: .leading) {
                HStack {
                    if let route = feedItem.routeInfo {
                        Text("\(route.0)")
                            .foregroundColor(.pink)
                            .font(.largeTitle)
                            .padding(.horizontal)
                    } else {
                        Image(systemName: "figure.wave")
                            .font(.system(size: 25))
                            .padding(.horizontal)
                    }
                    VStack(alignment: .leading) {
                        ForEach(sightingDict.sorted{return $0.value > $1.value},  id: \.key) { info, textOpacity in
                            Text(info)
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .opacity(textOpacity)
                        }
                    }
                    Spacer()
                    if let dist = getCurrentDistance() {
                        HStack {
                            Text(dist)
                                .foregroundColor(.pink)
                                .font(.subheadline)
                            Image(systemName: "location.fill")
                                .foregroundColor(.pink)
                                .font(.system(size: 10))
                        }
                    }
                }
                Divider()
                if !feedItem.description.isEmpty {
                    Text("Kommentar fra observatør:")
                        .font(.headline)
                        .padding()
                    Text("\(feedItem.description)")
                        .padding(.horizontal)
                        .font(.subheadline)
                }
                Spacer()
            }
        }
    }
    
    private func getCurrentDistance() -> String? {
        if let userLoc = locationManager.lastKnownLocation {
            var dist = distance(lon1: feedItem.location.longitude, lat1: feedItem.location.latitude, lon2: userLoc.longitude, lat2: userLoc.latitude)
            if dist >= 1000 {
                dist = dist / 1000
                dist = (round(10 * dist) / 10)
                return "\(dist)" + " km "
            } else {
                dist = round(dist)
                return "\(dist)" + " m "
            }
        } else {
            return nil
        }
    }
    
}

struct DetailMapView: View {
    var location: CLLocationCoordinate2D
    var markers: Array<Marker> {
        [Marker(location: MapMarker(coordinate: self.location))]
    }
    @State private var region: MKCoordinateRegion
    
    init(_ location: CLLocationCoordinate2D) {
        self.location = location
        region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: markers) { marker in
                marker.location
            }
        }
    }
}












struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let item = FeedItem(route: (1, "ASDASD jalla"), stop: "Prinsens gate P1", transportVehicle: "bus", author: UUID(), location: CLLocationCoordinate2D(latitude: 63.430230, longitude: 10.382971), 0, description: "GG")
        
        DetailView(feedItem: item, locationManager: LocationManager())
    }
}
