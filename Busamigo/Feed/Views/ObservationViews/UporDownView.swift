//
//  UporDownView.swift
//  Busamigo
//
//  Created by Nick Askari on 24/05/2022.
//

import SwiftUI

struct UporDownView: View {
    @EnvironmentObject private var feed: AtbFeed
    @EnvironmentObject private var tabvm: TabViewModel
    
    private let obs: Observation
    
    init(obs: Observation) {
        self.obs = obs
    }

    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                getTapticFeedBack(style: .medium)

                feed.upVoteObservation(obs) { success in
                    print("Upvote success:", success)
                    if success && tabvm.currentPage == .feed {
                        DispatchQueue.main.async {
                            feed.objectWillChange.send()
                        }
                    }
                }
            }, label: {
                Image(systemName: "chevron.up")
                    .font(.system(size: 30))
                    .foregroundColor(.mint)
            })
            .buttonStyle(PoppingButtonStyle3())
            .fixedSize()
            
            Text("\(feed.voteScoreFor(observation: obs))")
                .foregroundColor(.white)
                .font(.title2)
            
            Button(action: {
                getTapticFeedBack(style: .medium)

                feed.downVoteObservation(obs) { success in
                    print("Downvote success:", success)
                    if success && tabvm.currentPage == .feed {
                        DispatchQueue.main.async {
                            feed.objectWillChange.send()
                        }
                    }
                }
            }, label: {
                Image(systemName: "chevron.down")
                    .font(.system(size: 30))
                    .foregroundColor(.red)
            })
            .buttonStyle(PoppingButtonStyle3())
            .fixedSize()
        }
        .frame(width: 95)
    }
}








