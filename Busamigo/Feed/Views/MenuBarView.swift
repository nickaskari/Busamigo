//
//  MenuBarView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import SwiftUI

struct MenuBarView: View {
    var body: some View {
       
            HStack(alignment: .center) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 23))
                    .opacity(0)
                
                .padding(20)
                Spacer()
                Text("Trondheim")
                    .font(.bold(.title2)())
                Spacer()
                NavigationLink(destination: {
                    SearchView()
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .accentColor(.pink)
                        .font(.system(size: 23))
                })
                .padding(20)
            }
            .navigationTitle("Hovedfeed")
            .navigationBarHidden(true)
        
    }
}



struct MenuBarView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarView()
    }
}
