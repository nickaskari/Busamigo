//
//  ProfileView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI
import Shimmer
import FirebaseMessaging


struct ProfileView: View {
    @EnvironmentObject private var userManager: UserManager
    @EnvironmentObject private var profileButtonManager: ProfileButtonManager
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Min karisma")
                    .font(.headline)
                    .padding(.horizontal)
                
                if let karisma = userManager.getUserKarisma() {
                    KarismaView(value: karisma)
                        .padding(.bottom)
                } else {
                    KarismaView(value: 68)
                        .padding(.bottom)
                        .redacted(reason: .placeholder)
                        .shimmering()
                }
                
                Divider()
                
                legalInformation
                
                Divider()
                
                notificationsEnabler
                
                Spacer()
                
                TipsView()
                    .padding(.bottom)
            }
            .navigationTitle("Min profil")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                userManager.fetchUser()
            }
        }
    }
    
    private var legalInformation: some View {
        NavigationLink {
            AboutView()
        } label: {
            Image(systemName: "doc.text.fill")
                .profileIconStyle()
            
            Text("Om Busamigo")
                .font(.callout)
                .foregroundColor(.black)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.black)
        }
        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
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
}







struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
