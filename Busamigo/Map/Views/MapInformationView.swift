//
//  MapInformationView.swift
//  Busamigo
//
//  Created by Nick Askari on 01/06/2022.
//

import SwiftUI

struct MapInformationView: View {
    @Environment(\.presentationMode) var presentatinMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.pink)
                        .opacity(0.4)
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.pink)
                        .opacity(0.7)
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.pink)
                }
                
                Text("Jo sterkere rødfarge på observasjonen, jo mer nylig er den!")
                    .font(.headline)
                    .opacity(0.7)
                    .padding(.horizontal, 30)
                
                PreviewSlidingObservationView()
                
                Text("Trykk på en observasjon for å få opp observasjonskortet som vist over.")
                    .font(.headline)
                    .opacity(0.7)
                    .padding(.horizontal, 30)
                Text("Swipe til høyre for å fjerne den fra skjermen.")
                    .font(.subheadline)
                    .opacity(0.6)
                    .padding(.horizontal, 30)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentatinMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.pink)
                            .font(.system(size: 25))
                    })
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Hvordan bruke kartet")
                        .font(.headline)
                }
            }
        }
    }
}

struct MapInformationView_Previews: PreviewProvider {
    static var previews: some View {
        MapInformationView()
    }
}
