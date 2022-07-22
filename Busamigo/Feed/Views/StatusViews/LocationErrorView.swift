//
//  LocationErrorView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/04/2022.
//

import SwiftUI

struct LocationErrorView: View {
    let error: (Int, String)
    
    var body: some View {
        VStack {
            Text("Oida:/")
                .foregroundColor(.gray)
                .font(.largeTitle)
                .padding()
            Text(error.1)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .font(.callout)
                .padding(.horizontal)
            if error.0 != 3 {
                settingsButton
                    .padding(30)
            }
            Spacer()
        }
        .padding(.top)
    }
    
    var settingsButton: some View {
        Button(action: {
            self.settingsOpener()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(.pink)
                .foregroundColor(.white)
                Text("Dra til innstillinger")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            .scaledToFit()
        })
    }
    
    private func settingsOpener(){
        if let url = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    
}

struct LocationErrorView_Previews: PreviewProvider {
    static var previews: some View {
        LocationErrorView(error: (1, "asdad"))
    }
}
