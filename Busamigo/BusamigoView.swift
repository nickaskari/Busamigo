//
//  BusamigoView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI
import MapKit


struct BusamigoView: View {
    @ObservedObject var addManager: AddViewManager = AddViewManager()
  
    var body: some View {
        
        ZStack {
            TabView {
                FeedView(self.addManager)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Feed")
                    }
                OptionsView()
                    .tabItem {
                        Image(systemName: "line.horizontal.3")
                        Text("Options")
                    }
                MapView()
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("Map")
                    }
            }
            if self.addManager.isShowingAddPage() {
                AddFeedItemView(self.addManager)
                    .zIndex(1)
            } else {
                AddFeedItemView(self.addManager)
                    .zIndex(1)
            }
            
        }
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
