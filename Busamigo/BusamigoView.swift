//
//  BusamigoView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI

struct BusamigoView: View {
    
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Feed")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .edgesIgnoringSafeArea(.top)
        .accentColor(.pink)
        .preferredColorScheme(.light)
    }
}

























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BusamigoView()
            BusamigoView()
                .preferredColorScheme(.dark)
        }
    }
}
