//
//  DetailView.swift
//  Busamigo
//
//  Created by Nick Askari on 28/03/2022.
//

import SwiftUI
import MapKit

struct DetailView: View {
    var description: String
    var location: CLLocationCoordinate2D
    @Environment(\.dismiss) var dismiss
    
    init(description: String, location: CLLocationCoordinate2D) {
        self.description = description
        self.location = location
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 30))
                        .padding()
                        .accentColor(.black)
                }
                Spacer()
            }
            
            Text("Beskrivekse")
                .font(.headline)
            descriptionBubble
            DetailMapView(location)
                .scaledToFit()
                .padding(20)
            Spacer()
        }
    }
    
    var descriptionBubble: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.gray)
                .opacity(0.2)
            VStack(alignment: .leading) {
                Text("\(description)")
            }
            .scaledToFill()
        }
        .scaledToFit()
        .padding(.horizontal, 20)
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
            .cornerRadius(25)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(description: "dsa", location: CLLocationCoordinate2D(latitude: 63, longitude: 56))
    }
}
