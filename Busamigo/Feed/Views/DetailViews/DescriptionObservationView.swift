//
//  DescriptionObservationView.swift
//  Busamigo
//
//  Created by Nick Askari on 03/06/2022.
//

import SwiftUI

struct DescriptionObservationView: View {
    private let locationManager: LocationManager
    
    private let observation: Observation
    private let sightingDict: Array<(key: String, value: Double)>
    
    init(_ observation: Observation, _ locationManager: LocationManager) {
        self.observation = observation
        self.locationManager = locationManager
        self.sightingDict = createSightingDict(observation.getInformation())
    }
    
    var body: some View {
        HStack {
            if let route = observation.route {
                Text("\(route.nr)")
                    .routeNrStyle2()
            } else {
                Image(systemName: busOrTram(observation.stop))
                    .font(.system(size: 25))
                    .padding(.horizontal)
            }
            VStack(alignment: .leading) {
                ForEach(sightingDict,  id: \.key) { info, opacity in
                    Text(info)
                        .descriptionLine(color: .black, opacity)
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
    }
    
    private func getCurrentDistance() -> String? {
        if let userLoc = locationManager.lastKnownLocation {
            var dist = distance(lon1: observation.location.longitude, lat1: observation.location.latitude, lon2: userLoc.longitude, lat2: userLoc.latitude)
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
