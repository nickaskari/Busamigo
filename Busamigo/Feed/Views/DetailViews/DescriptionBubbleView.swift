//
//  DescriptionBubbleView.swift
//  Busamigo
//
//  Created by Nick Askari on 03/06/2022.
//

import SwiftUI

struct DescriptionBubbleView: View {
    private let locationManager: LocationManager
    
    private let observation: Observation
    private let sightingDict: Dictionary<String, Double>
    private let karisma: Double
    
    init(_ observation: Observation, _ locationManager: LocationManager, karisma: Double) {
        self.observation = observation
        self.locationManager = locationManager
        self.sightingDict = createSightingDict(observation.getInformation())
        self.karisma = karisma
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .opacity(0.0)
            VStack(alignment: .leading, spacing: 0) {
                DescriptionObservationView(observation, locationManager)
                    .padding(.bottom)
                
                Divider()
                
                Text("Observatørens karisma:")
                    .font(.headline)
                    .padding()
                KarismaView(value: karisma)
                
                if !observation.description.isEmpty {
                    Text("Kommentar fra observatør:")
                        .font(.headline)
                        .padding()
                    Text("\(observation.description)")
                        .padding(.horizontal)
                        .font(.subheadline)
                }
                Spacer()
            }
        }
        .padding()
    }
}
