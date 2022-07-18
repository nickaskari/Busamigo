//
//  LaunchView.swift
//  Busamigo
//
//  Created by Nick Askari on 03/07/2022.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject private var feed: AtbFeed
    @EnvironmentObject private var userManager: UserManager
    
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack {
            Color.launchViewColor.ignoresSafeArea()
            
            Image("Sombrero")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            ZStack {
                Text("BUSAMIGO")
                    .foregroundColor(.white)
                    .font(.system(.largeTitle, design: .rounded).bold())
            }
            .offset(y: 150)
        }
        .task {
            await userManager.signIn()
            
            feed.fetchFeed { success in
                if success {
                    feed.activateFilter("Relevant", userLon: nil, userLat: nil)
                }
                
                withAnimation(.easeOut) {
                    showLaunchView = false
                }
            }
            
            feed.listenForUpdates()
        }
    }
}










/*struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: true)
    }
}*/
