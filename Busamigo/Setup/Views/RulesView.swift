//
//  RulesView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/07/2022.
//

import SwiftUI

struct RulesView: View {
    @EnvironmentObject private var feed: FeedManager
    @EnvironmentObject private var locationManager: LocationManager
    @EnvironmentObject private var profileButtonManager: ProfileButtonManager
    @Environment(\.presentationMode) private var presentationMode
    
    @AppStorage("setup") private var setup = false
    @State private var showApp = false
    
    let isSetup: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 40) {
                    rules
                    
                    infoBubble
                    
                    nextButton
                        .opacity(0)
                        .disabled(true)
                    
                    Spacer()
                }
            }
    
            if isSetup {
                if #available(iOS 14, *) {
                    nextButton
                } else {
                    finishSetupButton
                }
            }
        }
        .padding(.top)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
            
            ToolbarItem(placement: .principal) {
                header
            }
        }
        .onReceive(profileButtonManager.objectWillChange) { object in
            if profileButtonManager.dismiss {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.pink)
                .font(.system(size: 20))
        })
    }
    
    private var header: some View {
        Text("Retningslinjer")
            .font(.headline)
    }
    
    private var nextButton: some View {
        NavigationLink {
            TrackingPermissionView()
        } label: {
            Text("Godta 👍")
                .capsuleStyle(.pink, size: .medium)
                .padding(.bottom)
        }
        .buttonStyle(PushDownButtonStyle())
    }
    
    private var finishSetupButton: some View {
        Button {
            self.setup = true
            self.showApp = true
        } label: {
            Text("Godta 👍")
                .capsuleStyle(.pink, size: .medium)
                .padding(.bottom)
        }
        .buttonStyle(PushDownButtonStyle())
        .fullScreenCover(isPresented: $showApp) {
            BusamigoView(feed, locationManager)
        }
    }
    
    private var rules: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Regler for bruk")
                .font(.headline)
            
            Text("Hatefulle ytringer i observasjoner på Busamigo er ikke tillatt, og kan medføre utestengelse.")
                .font(.callout)
            
            Text("Pålitelighet")
                .font(.headline)
            
            Text("For å vareta troverdigheten til observasjoner som publiseres i Busamigo, bes det om å ikke gi uriktige opplysninger. For å sikre dette kan brukere bekrefte eller avkrefte en observasjon vha. down- og upvotes. Antall down- og upvotes en bruker mottar påvirker vedkommendes “karisma” i Busamigo, slik at andre brukere kan få en indikasjon på observatørens troverdighet.")
                .font(.callout)
        }
        .padding(.horizontal, 20)
    }
    
    private var infoBubble: some View {
        HStack {
            Image(systemName: "exclamationmark.bubble")
                .foregroundColor(.pink)
                .font(.system(size: 25))
            
            Text("Busamigo anmoder brukere om å kjøpe billett til kollektivtransport i god tid, og tilrettelegger derfor en knapp for å besøke \(feed.organization) i hver observasjon.")
                .font(.caption)
                .minimumScaleFactor(0.01)
                .lineLimit(3)
                .foregroundColor(.black.opacity(0.7))
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 10))
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
    }
}







struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView(isSetup: true)
    }
}
