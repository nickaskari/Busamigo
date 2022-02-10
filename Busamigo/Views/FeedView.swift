//
//  FeedView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI

struct FeedView: View {
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    ForEach(0..<7) { item in
                        FeedItemView()
                    }
                }
                .navigationTitle("Vakt Feed🌍")
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 80))
                                .background(alignment: .center) {
                                    Color.white
                                        .mask(Circle())
                                }
                                .shadow(radius: 2)
                                .foregroundColor(.green)
                        }
                    }
                    .frame(width: 60, height: 60)
                    .padding(30)
                }
            }
        }
    }
}
































struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
