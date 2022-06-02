//
//  MapToolsView.swift
//  Busamigo
//
//  Created by Nick Askari on 01/06/2022.
//

import SwiftUI

struct MapToolsView: View {
    @ObservedObject private var observationManager: ObservationManager
    @ObservedObject private var locationManager: LocationManager
    @ObservedObject private var feed: AtbFeed
    
    @State var error = false
    @State private var isPresented = false
    //let color: Color = Color(red: 0.12, green: 0.12, blue: 0.12)
    
    init(_ feed: AtbFeed, _ locationManager: LocationManager, _ observationManager: ObservationManager) {
        self.feed = feed
        self.locationManager = locationManager
        self.observationManager = observationManager
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Button(action: { isPresented = true },
                       label: {
                        Image(systemName: "info")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .padding(17)
                            .background(Circle().foregroundColor(.white).shadow(radius: 5))
                        }
                )
                .sheet(isPresented: $isPresented) {
                    MapInformationView()
                }
                
                Button(action: {
                    locationManager.checkIfLocationServicesIsEnabled()
                    if !locationManager.hasAnyErrors(feed) {
                        if let location = locationManager.lastKnownLocation {
                            observationManager.showUserLocation(location)
                            if !locationManager.hasAuthErrors(feed) {
                                locationManager.unableToGetLocation = false
                            }
                            error = false
                        } else {
                            if !locationManager.hasAuthErrors(feed) {
                                locationManager.unableToGetLocation = true
                            }
                            error = true
                        }
                    } else {
                        error = true
                    }
                }, label: {
                    Image(systemName: "location.fill")
                        .font(.system(size: 15))
                        .foregroundColor(.blue)
                        .padding(15)
                        .background(Circle().foregroundColor(.white).shadow(radius: 5))
                })
                .alert(isPresented: $error) {
                    Alert(title: Text("Busamigo finner ikke posisjonen din!"), message: Text("Sjekk innstillingene dine eller prøv igjen."), dismissButton: .default(Text("Skjønner!")))
                }
            }
        }
        .padding()
    }
}







