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
    @EnvironmentObject private var feed: FeedManager
    
    @State private var isLoading = true
    @State private var karisma: Double?
    @State private var describeReasonForFlagging: Bool = false
    
    init(observation: Observation, locationManager: LocationManager) {
        self.observation = observation
        self.locationManager = locationManager
    }
    
    
    var body: some View {
        mainView
            .onAppear {
                userManager.getAuthorKarisma(id: observation.author) { karisma in
                    if let karisma = karisma {
                        self.karisma = karisma
                        self.isLoading = false
                    }
                }
            }
            .onReceive(homeButtonManager.objectWillChange, perform: { object in
                if homeButtonManager.dismiss {
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
    
    private let height = UIScreen.screenHeight * 0.86
    
    private var mainView: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                DetailMapView(observation.getCLLocationCoordinate2D())
                
                if isLoading {
                    DescriptionSlabView(observation, locationManager, karisma: 68)
                        .redacted(reason: .placeholder)
                        .shimmering()
                } else {
                    DescriptionSlabView(observation, locationManager, karisma: self.karisma ?? 50)
                }
            }
            
            purchaseTicketButton
                .position(x: geo.size.width * 0.5, y: height)
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
    
    private var purchaseTicketButton: some View {
        HStack {
            Spacer()
            
            Button {
                if let url = URL(string: "itms-apps://apple.com/us/app/atb/id1502395251") {
                    UIApplication.shared.open(url)
                }
            } label: {
                HStack {
                    Text(feed.support)
                    
                    Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                        .font(.system(size: 14))
                }
                .capsuleStyle(.pink, size: .small)
            }
                .buttonStyle(PushDownButtonStyle())
            
            Spacer()
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
