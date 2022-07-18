//
//  TrackingPermissionView.swift
//  Busamigo
//
//  Created by Nick Askari on 16/07/2022.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport

struct TrackingPermissionView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var feed: FeedManager
    @EnvironmentObject private var locationManager: LocationManager
    
    @AppStorage("setup") private var setup = false
    @AppStorage("areAdsEnabled") var areAdsEnabled: Bool = false
    @State private var showApp = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 40) {
                header
                
                description
                
                benefits
                
                Spacer()
            }
            .padding()
    
            finishSetupButton
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
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
        HStack {
            Text(getIOSversion())
                .font(.title.bold())
            
            Spacer()
            
            Image("SombreroGray")
                .resizable()
                .frame(width: 60, height: 40)
                .padding(.horizontal)
        }
    }
    
    private var description: some View {
        Text("Denne versjonen av iOS krever tillatelse til å spore aktiviteten din. Dette gjøres i sammenheng med å tilby mer relevante annonser til deg.\n\nHvis du velger å slå på dette kan du:")
            .font(.callout)
            .lineLimit(7)
            .minimumScaleFactor(0.01)
    }
    
    private var benefits: some View {
        VStack(alignment: .leading, spacing: 20) {
            makeBenefit(icon: "person.3.fill", benefit: "bidra til at Busamigo forblir gratis på App Store")
            makeBenefit(icon: "hand.point.up.braille.fill", benefit: "få mer relavante annonser")
        }
    }
    
    private var finishSetupButton: some View {
        Button {
            self.setup = true
            self.showApp = true
            
            requestIDFA()
        } label: {
            Text("Neste")
                .capsuleStyle(.pink, size: .medium)
                .padding(.bottom)
        }
        .buttonStyle(PushDownButtonStyle())
        .fullScreenCover(isPresented: $showApp) {
            BusamigoView(feed, locationManager)
        }
    }
    
    private func makeBenefit(icon: String, benefit: String) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 25))
                .frame(width: 80)
            
            Text(benefit)
                .font(.callout)
                .foregroundColor(.gray)
                .minimumScaleFactor(0.01)
                .lineLimit(2)
        }
    }
    
    private func getIOSversion() -> String {
        let version: String = UIDevice.current.systemVersion
        return "Du har iOS " + version
    }
    
    private func requestIDFA() {
      ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
          self.areAdsEnabled = true
      })
    }
}













struct TrackingPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingPermissionView()
    }
}
