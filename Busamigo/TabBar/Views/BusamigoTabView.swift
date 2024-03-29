//
//  BusamigoTabView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI

struct BusamigoTabView: View {
    @ObservedObject private var tabvm: TabViewModel
    @ObservedObject private var feed: FeedManager
    @EnvironmentObject private var homeButtonManager: HomeButtonManager
    @EnvironmentObject private var profileButtonManager: ProfileButtonManager
    @Environment(\.presentationMode) private var presentationMode
    
    init(_ feed: FeedManager, _ tabvm: TabViewModel) {
        self.feed = feed
        self.tabvm = tabvm
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Divider()
            
            HStack(spacing: 110) {
                buttonTab(name: "Feed", icon: "house.fill", page: .feed)
                buttonTab(name: "Kart", icon: "map.fill", page: .map)
                buttonTab(name: "Profil", icon: "person.fill", page: .profile)
            }
            .frame(width: UIScreen.screenWidth)
        }
        .padding(.bottom, 5)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func buttonTab(name: String, icon: String, page: Page) -> some View {
        Button {
            tabvm.currentPage = page
            switch page {
            case .feed:
                print("pressed feed")
                homeButtonManager.scrollToTop = true
                homeButtonManager.dismiss = true
            case .profile:
                print("pressed profile")
                profileButtonManager.dismiss = true
            case .map:
                print("pressed map")
                break
            }
            
        } label: {
            VStack(spacing: 2) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(tabvm.currentPage == page ? .pink : .black.opacity(0.6))
                Text(name)
                    .foregroundColor(.black)
                    .font(.caption)
            }
        }
        .buttonStyle(TabBarButtonStyle())
    }
}









struct BusamigoTabView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        BusamigoTabView(FeedManager(), TabViewModel())
    }
}
