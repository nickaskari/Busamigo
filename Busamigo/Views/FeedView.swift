//
//  FeedView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI

struct FeedView: View {
    //TODO: Tilknytning til ViewModels
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    //Foreløpig
                    ForEach(0..<7) { item in
                        BusCardView(rating: 89, sighting: "Lohove 3:Hospitalkirka:2022")
                        BusStopCardView(rating: 21, sighting: "Kongens Gate 1:1721")
                        TramCardView(rating: -3, sighting: "Lian 1:Munkholmen:1512")
                    }
                }
                .navigationTitle("Trondheim👀")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            print("gg")
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .accentColor(.pink)
                                .font(.system(size: 25))
                        }
                    }
                }
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
                                .foregroundColor(.pink)
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
