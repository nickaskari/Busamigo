//
//  WelcomeView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/07/2022.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("Velkommen til Busamigo!")
                        .font(.title.bold())
                        .padding()
                    
                    descriptionImages
                    
                    description
                }
                
                nextButton
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
    
    private var description: some View {
        VStack(alignment: .leading, spacing: 20) {
            getBulletpoint(nr: 1, content: "Meld fra om vekter på kollektiv transport")
            getBulletpoint(nr: 2, content: "Se hvor det er meldt fra om vekter på feeden eller på kartet")
            getBulletpoint(nr: 3, content: "Gi en upvote på de du synes er rimelig ;)")
            
            Spacer()
        }
        .padding()
    }
    
    private var descriptionImages: some View {
        HStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "bus.fill")
                .font(.system(size: 120))
                .foregroundColor(.gray)
            Image(systemName: "tram.fill")
                .font(.system(size: 120))
            
            Spacer()
        }
    }
    
    private var nextButton: some View {
        NavigationLink {
            SetupNotificationsView()
        } label: {
            Text("Neste")
                .capsuleStyle(.pink, size: .medium)
        }
        .buttonStyle(PushDownButtonStyle())
        .padding(.bottom)
    }
    
    private func getBulletpoint(nr: Int, content: String) -> some View {
        let circleText = String(nr) + ".circle.fill"
        
        return HStack(spacing: 15) {
            Image(systemName: circleText)
                .font(.system(size: 40))
                .foregroundColor(.pink)
            
            Text(content)
                .font(.title3)
        }
    }
    

}














struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
