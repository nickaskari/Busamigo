//
//  AboutView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var profileButtonManager: ProfileButtonManager
    @EnvironmentObject private var tabViewModel: TabViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            privacyRow
            
            Divider()
            
            rulesRow
            
            Divider()
            
            contactRow
            
            Spacer()
            
            versionInfo
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
            
            ToolbarItem(placement: .principal) {
                header
            }
        }
        .padding(.top)
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
        Text("Om Busamigo")
            .font(.headline)
    }
    
    
    private var privacyRow: some View {
        Button {
            if let url = URL(string: "https://nickaskari.github.io/Busamigo.site/") {
               UIApplication.shared.open(url)
            }
        } label: {
            getButtonLabel("Personvern", icon: "doc.text.fill")
        }
    }
    
    private var rulesRow: some View {
        NavigationLink {
            RulesView(isSetup: false)
        } label: {
            getButtonLabel("Retningslinjer", icon: "doc.text.fill")
        }
    }
    
    private var contactRow: some View {
        Button {
            openTwitter()
        } label: {
            getButtonLabel("Kontakt Busamigo", icon: "bubble.left.and.bubble.right.fill")
        }
    }
    
    private var versionInfo: some View {
        HStack {
            Spacer()
            
            VStack(spacing: 15) {
                Image("SombreroGray")
                    .resizable()
                    .frame(width: 120, height: 80)
                
                Text("Versjon \(UIApplication.version)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(20)
    }
    
    private func getButtonLabel(_ text: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .profileIconStyle()
            
            Text(text)
                .font(.callout)
                .foregroundColor(.black)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.black)
        }
        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
    }
    
    private func openTwitter() {
       let appURL = URL(string: "twitter://user?screen_name=busamigo")!
       let application = UIApplication.shared
     
       if application.canOpenURL(appURL) {
          application.open(appURL)
       } else {
           let webURL = URL(string: "https://twitter.com/busamigo")!
           application.open(webURL)
       }
     
    }
}







struct AboutBusamigoView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
