//
//  ProfileView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI

struct ProfileView: View {
    @State private var karismaAmount = 70.0
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Min karisma")
                    .font(.headline)
                    .padding(.horizontal)
                KarismaView(value: karismaAmount)
                    .padding(.bottom)
                
                Divider()
                
                legalInformation
                
                Spacer()
                
                TipsView()
                    .padding(.bottom)
            }
            .navigationTitle("Min profil")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var legalInformation: some View {
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
