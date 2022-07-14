//
//  LegalInformationView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI

struct LegalInformationView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            makePrivacyRow()
            
            Divider()
            
            makeRulesRow()
            
            Spacer()
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
    
    
    private func makePrivacyRow() -> some View {
        Button {
            if let url = URL(string: "https://nickaskari.github.io/Busamigo.site/") {
               UIApplication.shared.open(url)
            }
        } label: {
            getButtonLabel("Personvern")
        }
    }
    
    private func makeRulesRow() -> some View {
        NavigationLink {
            RulesView(isSetup: false)
        } label: {
            getButtonLabel("Retningslinjer")
        }
    }
    
    private func getButtonLabel(_ text: String) -> some View {
        HStack {
            Image(systemName: "doc.text.fill")
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
}







struct AboutBusamigoView_Previews: PreviewProvider {
    static var previews: some View {
        LegalInformationView()
    }
}
