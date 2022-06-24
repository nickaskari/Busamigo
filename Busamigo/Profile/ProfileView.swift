//
//  ProfileView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI
import Shimmer

// save karisma in userManager, some listener from firebase idk

struct ProfileView: View {
    @EnvironmentObject private var userManager: UserManager
    
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
            LegalInformationView()
        } label: {
            Text("Juridisk informasjon")
                .font(.callout)
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.black)
        }
        .padding()
    }
}







struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
