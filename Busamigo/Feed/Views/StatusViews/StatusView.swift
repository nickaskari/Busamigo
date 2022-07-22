//
//  StatusView.swift
//  Busamigo
//
//  Created by Nick Askari on 22/07/2022.
//

import SwiftUI

struct StatusView: View {
    @EnvironmentObject private var homeButtonManager: HomeButtonManager
    @EnvironmentObject private var feed: FeedManager
    
    
    var body: some View {
        if feed.status != .none {
            if feed.status == .newObservations {
                newObservationsButton()
            } else {
                genericLabel()
            }
        }
    }
    
    private func genericLabel() -> some View {
        Text(feed.status.message)
            .capsuleStyle(.pink, size: .small)
            .padding(15)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    withAnimation {
                        feed.status = .none
                    }
                }
            }
            .position(x: UIScreen.screenWidth / 2, y: 45)
    }
    
    private func newObservationsButton() -> some View {
        Button {
            homeButtonManager.scrollToTop = true
        } label: {
            HStack(spacing: 20) {
                Text(feed.status.message)
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
                    feed.status = .none
                }
            }
        }
        .position(x: UIScreen.screenWidth / 2, y: 45)
    }
}

/*struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView(status: .redundantVote)
    }
}*/
