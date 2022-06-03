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
    //TODO: TAKE IN FEED ITEM INSTEAD
    
    let color: Color = Color(red: 0.12, green: 0.12, blue: 0.12)
    let opacity: Double = 1
    let rating: Int
    let sighting: String
    let routeNr: Int?
    
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
                if let routeNr = routeNr {
                    Text("\(routeNr)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(width: 95)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                } else {
                    Image(systemName: "figure.wave")
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                        .frame(width: 95)
                }
                VStack(alignment: .leading) {
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


struct FeedItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeedItemView(rating: 12, sighting: "Lohove mot sentrumdsdsddsdsdsdsdssddsdsdsds;Hallset;18:15", routeNr: 5626)
    }
}










