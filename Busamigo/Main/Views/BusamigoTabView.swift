//
//  BusamigoTabView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI

struct BusamigoTabView: View {
    @ObservedObject private var tabvm: TabViewModel
    @ObservedObject private var feed: AtbFeed
    @EnvironmentObject private var scrollManager: ScrollManager
    
    init(_ feed: AtbFeed, _ tabvm: TabViewModel) {
        self.feed = feed
        self.tabvm = tabvm
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Divider()
            HStack(spacing: 110) {
                buttonTab(name: "Feed", icon: "house.fill", page: .feed)
                buttonTab(name: "Profil", icon: "person.fill", page: .profile)
                buttonTab(name: "Kart", icon: "map.fill", page: .map)
            }
            .frame(width: UIScreen.screenWidth)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func buttonTab(name: String, icon: String, page: Page) -> some View {
        Button {
            tabvm.currentPage = page
            /*if name == "Feed" {
                scrollManager.scrollToTop = true
            }*/
        } label: {
            VStack(spacing: 2) {
                Image(systemName: icon)
                    .font(.system(size: 25))
                    .foregroundColor(tabvm.currentPage == page ? .pink : .black.opacity(0.6))
                Text(name)
                    .foregroundColor(.black)
                    .font(.caption)
            }
        }
        .buttonStyle(PoppingButtonStyle2())
    }
}









struct BusamigoTabView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        BusamigoTabView(AtbFeed(), TabViewModel())
    }
}
