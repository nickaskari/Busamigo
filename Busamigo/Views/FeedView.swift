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
            ZStack {
                VStack(alignment: .trailing) {
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
                            }
                        }
                        .frame(width: 60, height: 60)
                        .border(Color.red, width: 1)
                    }
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
