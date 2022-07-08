//
//  SetupNotificationsView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/07/2022.
//

import SwiftUI

struct SetupNotificationsView: View {
    @EnvironmentObject private var userManager: UserManager
    @EnvironmentObject private var feed: AtbFeed
    @EnvironmentObject private var locationManager: LocationManager
    @Environment(\.presentationMode) private var presentationMode
    
    @AppStorage("setup") private var setup = false
    @State private var showApp = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 40) {
                backButton
                
                Text("Vil du skru på push varsler hver gang det blir observert vekter?")
                    .font(.title2.bold())
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
                
                notificationsEnabler
                
                infoBubble
                
                Spacer()
            }
            
            nextButton
        }
        .navigationBarHidden(true)
    }
    
    private var notificationsEnabler: some View {
        Toggle(isOn: $userManager.isNotificationsEnabled) {
            Image(systemName: "bell.fill")
                .profileIconStyle()
            
            Text("Få varsler")
                .font(.callout)
                .foregroundColor(.black)
        }
        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
        .tint(.pink)
    }
    
    private var infoBubble: some View {
        HStack {
            Image(systemName: "exclamationmark.bubble")
                .foregroundColor(.pink)
                .font(.system(size: 60))
            
            Text("Husk at notifikasjoner for Busamigo må være på i innstillingene dine for dette :)")
                .foregroundColor(.black.opacity(0.7))
        }
        .padding()
    }
    
    private var nextButton: some View {
        Button {
            self.setup = true
            self.showApp = true
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
    
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.pink)
                .font(.system(size: 20))
        })
            .padding(.horizontal)
    }
}










struct SetupNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        SetupNotificationsView()
    }
}
