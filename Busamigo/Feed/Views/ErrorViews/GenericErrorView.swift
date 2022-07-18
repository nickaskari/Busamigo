//
//  GenericErrorView.swift
//  Busamigo
//
//  Created by Nick Askari on 19/06/2022.
//

import SwiftUI

struct GenericErrorView: View {
    @EnvironmentObject private var feed: FeedManager
    
    var body: some View {
        Text("Ops! Det har oppstått et problem.")
            .capsuleStyle(.pink, size: .small)
            .padding(15)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    withAnimation {
                        feed.networkError = false
                    }
                }
            }
    }
}

struct GenericErrorView_Previews: PreviewProvider {
    static var previews: some View {
        GenericErrorView()
    }
}
