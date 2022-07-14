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
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 40) {
                Text("Vil du skru på push varsler hver gang det blir observert vekter?")
                    .font(.title2.bold())
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
                
                notificationsEnabler
                
                infoBubble
                
                Spacer()
            }
            
            nextButton
        }
        .padding(.top)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
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
        NavigationLink {
            RulesView(isSetup: true)
        } label: {
            Text("Neste")
                .capsuleStyle(.pink, size: .medium)
                .padding(.bottom)
        }
        .buttonStyle(PushDownButtonStyle())
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
}










struct SetupNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        SetupNotificationsView()
    }
}
