//
//  LaunchView.swift
//  Busamigo
//
//  Created by Nick Askari on 03/07/2022.
//

import SwiftUI
import Shimmer

struct LaunchView: View {
    @EnvironmentObject private var feed: AtbFeed
    @EnvironmentObject private var userManager: UserManager
    
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            Image(systemName: "bus.fill")
                .resizable()
                .frame(width: 123, height: 130)
                .foregroundColor(.pink)
            
            ZStack {
                Text("BUSAMIGO")
                    .foregroundColor(.pink)
                    .font(.largeTitle)
                    .shimmering()
            }
            .offset(y: 150)
        }
        .task {
            feed.fetchFeed { success in
                if success {
                    feed.activateFilter("Relevant", userLon: nil, userLat: nil)
                }
                showLaunchView = false
            }
            await userManager.signIn()
        }
    }
}










/*struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}*/
