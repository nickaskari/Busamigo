//
//  PostMapAnnotationView.swift
//  Busamigo
//
//  Created by Nick Askari on 31/05/2022.
//

import SwiftUI

struct PostMapAnnotationView: View {
    @ObservedObject private var observationManager: ObservationManager
    private var post: FeedItem
    
    init(_ post: FeedItem, _ observationManager: ObservationManager) {
        self.post = post
        self.observationManager = observationManager
    }
    
    var body: some View {
        VStack {
            withAnimation {
                Text(getTimeFromNow(date: post.conceptionDate).0)
                        .font(.callout)
                        .padding(5)
                        .background(Color(.white))
                        .cornerRadius(10)
                        .opacity(observationManager.mapObservation == post ? 1 : 0)
            }
            Image(systemName: "mappin.circle.fill")
                .font(.system(size: 30))
                .foregroundColor(.pink)
                .opacity(getTimeFromNow(date: post.conceptionDate).1)
        }
    }
}











