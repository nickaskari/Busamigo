//
//  FeedItemView.swift
//  Busamigo
//
//  Created by Nick Askari on 10/02/2022.
//

import SwiftUI
import Foundation

//Geralisering av Card

struct FeedItemView: View {
    let color: Color
    let opacity: Double
    let isBus: Bool
    let rating: Int
    let sighting: String
    
    private var icon: String {
        if isBus == true {
            return "bus"
        }
        else {
            return "tram"
        }
    }
    
    private var sightingDict: Dictionary<String, Double> {
        var opacityValue: Double = 1.0
        var dict: Dictionary<String, Double> = [ : ]
        for info in sighting.components(separatedBy: ":") {
            dict[info] = opacityValue
            opacityValue -= 0.2
        }
        return dict
    }
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(color)
                .opacity(opacity)
                .aspectRatio(2, contentMode: .fit)
            
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 30))
                    .padding(.horizontal)
                    .foregroundColor(Color.init(red: 1, green: 1, blue: 1))
                VStack(alignment: .leading) {
                    ForEach(sightingDict.sorted{return $0.value > $1.value},  id: \.key) { info, textOpacity in
                        Text(info)
                            .font(.title2)
                            .foregroundColor(.white)
                            .opacity(textOpacity)
                        }
                }
                Spacer()
                UporDownView(rating: String(rating))
            }
        }
        .padding(.horizontal)
    }
    
    struct UporDownView: View {
        let rating: String
        
        var body: some View {
            VStack {
                Image(systemName: "arrow.up")
                    .font(.system(size: 30))
                    .foregroundColor(.mint)
                    .padding(.bottom)
                Text("\(rating)")
                    .foregroundColor(.white)
                    .font(.title2.bold())
                    .padding(.bottom)
                Image(systemName: "arrow.down")
                    .font(.system(size: 30))
                    .foregroundColor(.red)
            }
            .padding(30)
        }
    }
}













struct FeedItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeedItemView(color: .black, opacity: 0.7, isBus: true, rating: 12, sighting: "Xest:adsd:1645")
    }
}
