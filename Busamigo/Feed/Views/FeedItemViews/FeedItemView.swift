//
//  FeedItemView.swift
//  Busamigo
//
//  Created by Nick Askari on 10/02/2022.
//

import SwiftUI
import Foundation

//Geralisering av FeedItem

struct FeedItemView: View {
    let color: Color = Color(red: 0.12, green: 0.12, blue: 0.12)
    let opacity: Double = 1
    let rating: Int
    let sighting: String
    let vehicle: String
    
    private var sightingDict: Dictionary<String, Double> {
        createSightingDict(sighting)
    }
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(color)
                .opacity(opacity)
                .aspectRatio(2.5, contentMode: .fit)
                
            HStack {
                Image(systemName: vehicle)
                    .font(.system(size: 25))
                    .foregroundColor(.pink)
                    .padding(15)
                    .background(Capsule(style: .circular)
                                    .foregroundColor(.black))
                    .padding()
                LazyVStack(alignment: .leading) {
                    ForEach(sightingDict.sorted{return $0.value > $1.value},  id: \.key) { info, textOpacity in
                        Text(info)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .opacity(textOpacity)
                        }
                }
                Spacer()
                UporDownView(rating: String(rating))
            }
        }
        .padding(.horizontal)
        .shadow(radius: 15)
    }
}













