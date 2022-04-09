//
//  AppBarView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import SwiftUI

struct AppBarView: View {
    
    var body: some View {
        HStack(alignment: .center) {
            
            Image(systemName: "magnifyingglass")
                .font(.system(size: 23))
                .opacity(0)
            
            Image(systemName: "plus")
                .padding(20)
                .font(.system(size: 23))
                .opacity(0)
            
            Spacer()
            
            Image(systemName: "mappin.circle")
                .font(.system(size: 23))
                .shadow(radius: 1)
                .foregroundColor(.pink)
            Text("Trondheim")
                .font(.bold(.title2)())
            
            Spacer()
            
            Image(systemName: "plus")
                .foregroundColor(.pink)
                .font(.system(size: 23))
                .shadow(radius: 1)
                .opacity(0)
            
            NavigationLink(destination: {
                FeedSearchView()
            }, label: {
                Image(systemName: "magnifyingglass")
                    .accentColor(.black)
                    .font(.system(size: 23))
                    .shadow(radius: 1)
                    .padding(20)
            })
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}



struct AppBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppBarView()
    }
}
