//
//  NewMapObservationView.swift
//  Busamigo
//
//  Created by Nick Askari on 23/06/2022.
//

import SwiftUI

struct NewMapObservationView: View {
    @EnvironmentObject private var feed: FeedManager
    @State private var isLoading = false
    
    var body: some View {
        Button {
            isLoading = true
            
            feed.fetchFeed { success in
                isLoading = false
            }
        } label: {
            HStack(spacing: 20) {
                Text("Trykk for ny observasjon")
                
                if isLoading {
                    ActivityIndicator(color: .white)
                }
            }
            .capsuleStyle(.pink, size: .small)
            .padding(15)
        }
        .buttonStyle(PushDownButtonStyle())
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    feed.status = .none
                }
            }
        }
    }
}






struct NewMapObservationView_Previews: PreviewProvider {
    static var previews: some View {
        NewMapObservationView()
    }
}
