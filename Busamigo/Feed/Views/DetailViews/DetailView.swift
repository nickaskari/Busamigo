//
//  DetailView.swift
//  Busamigo
//
//  Created by Nick Askari on 28/03/2022.
//

import SwiftUI
import MapKit
import Shimmer

struct DetailView: View {
    private let observation: Observation
    private let locationManager: LocationManager
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var userManager: UserManager
    
    @State private var isLoading = true
    @State private var karisma: Double?
    
    init(observation: Observation, locationManager: LocationManager) {
        self.observation = observation
        self.locationManager = locationManager
    }
    
    var body: some View {
        VStack {
            DetailMapView(observation.getCLLocationCoordinate2D())
            
            if isLoading {
                DescriptionBubbleView(observation, locationManager, karisma: 68)
                    .redacted(reason: .placeholder)
                    .shimmering()
            } else {
                DescriptionBubbleView(observation, locationManager, karisma: self.karisma ?? 50)
            }
        }
        .onAppear {
            userManager.getAuthorKarisma(id: observation.author) { karisma in
                if let karisma = karisma {
                    self.karisma = karisma
                    self.isLoading = false
                }
            }
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
        let item = Observation(route: Route(nr: 3, name: "Lohove mot sentrum"), stop: Stop(name: "Kongens gate", vehicle: 700), author: "someID", location: CLLocationCoordinate2D(), voteScore: 12, description: "")
        
        DetailView(observation: item, locationManager: LocationManager())
    }
}
