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
    private let karisma: Double
    
    init(_ observation: Observation, _ locationManager: LocationManager, karisma: Double) {
        self.observation = observation
        self.locationManager = locationManager
        self.karisma = karisma
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DescriptionObservationView(observation, locationManager)
                .padding(.bottom)
            
            Divider()
            
            ZStack(alignment: .bottom) {
                infoScroll
                
                purchaseTicketButton
            }
        }
        .padding()
    }
    
    private var infoScroll: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Observatørens karisma:")
                    .font(.subheadline.bold())
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 3, trailing: 0))
                
                KarismaView(value: karisma)
                
                if !observation.description.isEmpty {
                    Text("Kommentar fra observatør:")
                        .font(.subheadline.bold())
                        .padding(EdgeInsets(top: 12, leading: 8, bottom: 3, trailing: 0))
                    Text("\(observation.description)")
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                        .font(.subheadline)
                }
                
                purchaseTicketButton
                    .opacity(0)
                    .disabled(true)
            }
        }
    }
    
    private var purchaseTicketButton: some View {
        HStack {
            Spacer()
            
            Button {
                if let url = URL(string: "itms-apps://apple.com/us/app/atb/id1502395251") {
                    UIApplication.shared.open(url)
                }
            } label: {
                Text("Kjøp billett")
                    .capsuleStyle(.pink, size: .small)
            }
                .buttonStyle(PushDownButtonStyle())
            
            Spacer()
        }

    }
}
