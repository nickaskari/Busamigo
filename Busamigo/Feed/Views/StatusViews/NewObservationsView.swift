//
//  NewObservationsView.swift
//  Busamigo
//
//  Created by Nick Askari on 22/06/2022.
//

import SwiftUI

struct NewObservationsView: View {
    @EnvironmentObject private var homeButtonManager: HomeButtonManager
    @EnvironmentObject private var feed: FeedManager
    
    var body: some View {
        Button {
            homeButtonManager.scrollToTop = true
        } label: {
            HStack(spacing: 20) {
                Text("Nye observasjoner")
                Image(systemName: "arrow.up")
                    .font(.system(size: 15))
            }
            .capsuleStyle(.pink, size: .small)
            .padding(15)
        }
        .buttonStyle(PushDownButtonStyle())
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    feed.newObservations = false
                }
            }
        }
        .position(x: UIScreen.screenWidth / 2, y: 45)
    }
}







struct NewObservationsView_Previews: PreviewProvider {
    static var previews: some View {
        NewObservationsView()
    }
}
