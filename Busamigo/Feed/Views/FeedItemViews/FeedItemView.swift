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
    let color: Color = Color(red: 0.15, green: 0.15, blue: 0.15)
    let opacity: Double = 1
    let rating: Int
    let sighting: String
    let vehicle: String
    
    private var sightingDict: Dictionary<String, Double> {
        createSightingDict(sighting)
    }
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 20)
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
                VStack(alignment: .leading) {
                    ForEach(sightingDict.sorted{return $0.value > $1.value},  id: \.key) { info, textOpacity in
                        Text(info)
                            .font(.title3)
                            .foregroundColor(.white)
                            .opacity(textOpacity)
                        }
                }
                Spacer()
                UporDownView(rating: String(rating))
            }
        }
        .padding(.horizontal)
        .shadow(radius: 5)
    }
    
    struct UporDownView: View {
        let rating: String
        
        var body: some View {
            VStack {
                Image(systemName: "chevron.up")
                    .font(.system(size: 30))
                    .foregroundColor(.mint)
                Text("\(rating)")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                Image(systemName: "chevron.down")
                    .font(.system(size: 30))
                    .foregroundColor(.red)
            }
            .padding(30)
        }
    }
}













