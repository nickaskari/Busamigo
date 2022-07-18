//
//  RulesView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/07/2022.
//

import SwiftUI

struct RulesView: View {
    @EnvironmentObject private var feed: AtbFeed
    @EnvironmentObject private var locationManager: LocationManager
    @Environment(\.presentationMode) private var presentationMode
    
    @AppStorage("setup") private var setup = false
    @State private var showApp = false
    
    let isSetup: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 40) {
                rules
                
                infoBubble
                
                Spacer()
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
            Text("Enig 👍")
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
            Text("Enig 👍")
                .capsuleStyle(.pink, size: .medium)
                .padding(.bottom)
        }
        .buttonStyle(PushDownButtonStyle())
        .fullScreenCover(isPresented: $showApp) {
            BusamigoView(feed, locationManager)
        }
    }
    
    private var rules: some View {
        Text("Busamigo er ment som et fantastisk verktøy for å være foreberedt på billettkontroll for kollektiv transport. For å bruke denne platformen krever vi at brukere unngår hatefulle ytringer i sine observasjoner, dette kan føre til utestengelse av brukeren.")
            .font(.callout)
            .minimumScaleFactor(0.01)
            .lineLimit(10)
            .padding(.horizontal, 20)
    }
    
    private var infoBubble: some View {
        HStack {
            Image(systemName: "exclamationmark.bubble")
                .foregroundColor(.pink)
                .font(.system(size: 25))
            
            Text("Busamigo oppfordrer til å kjøpe billett i god tid, og tilrettelegger derfor en knapp for dette i hver observasjon.")
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
