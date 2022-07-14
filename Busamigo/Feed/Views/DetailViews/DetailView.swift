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
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject private var userManager: UserManager
    @EnvironmentObject private var homeButtonManager: HomeButtonManager
    
    @State private var isLoading = true
    @State private var karisma: Double?
    @State private var describeReasonForFlagging: Bool = false
    
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
        .onReceive(homeButtonManager.$dismiss, perform: { dismiss in
            if dismiss {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
            
            ToolbarItem(placement: .principal) {
                header
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                flagButton
            }
        }
        .fullScreenCover(isPresented: $describeReasonForFlagging) {
            FlaggingReasonView(observation: self.observation)
        }
    }
    
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .toolBarButton()
                .foregroundColor(.pink)
                .font(.system(size: 20))
        })
    }
    
    private var header: some View {
        Text("Beskrivelse")
            .font(.headline)
            .padding(8)
            .background(Capsule(style: .circular)
                .foregroundColor(.white))
            .shadow(radius: 1)
    }
    
    private var flagButton: some View {
        Menu {
            Button("Flagg observasjon", role: .destructive) {
                self.describeReasonForFlagging = true
            }
            
            Button("Skjul observasjon") {
                addToHiddenObservations()
                presentationMode.wrappedValue.dismiss()
            }

        } label: {
            Image(systemName: "flag.fill")
                .toolBarButton()
                .foregroundColor(.pink)
                .font(.system(size: 14))
        }
    }
    
    private func addToHiddenObservations() {
        let savedObs = HiddenObservations(context: moc)
        savedObs.docID = observation.id ?? ""
        
        try? moc.save()
    }
}












struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let item = Observation(route: Route(nr: 3, name: "Lohove mot sentrum"), stop: Stop(name: "Kongens gate", vehicle: 700), author: "someID", location: CLLocationCoordinate2D(), voteScore: 12, description: "")
        
        DetailView(observation: item, locationManager: LocationManager())
    }
}
