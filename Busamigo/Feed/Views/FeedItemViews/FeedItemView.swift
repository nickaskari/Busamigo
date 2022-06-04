//
//  FeedItemView.swift
//  Busamigo
//
//  Created by Nick Askari on 10/02/2022.
//

import SwiftUI
import MapKit
import Foundation

struct FeedItemView: View {
    private let color: Color = Color(red: 0.12, green: 0.12, blue: 0.12)
    private let opacity: Double = 1
    
    private let item: FeedItem
    private let sightingDict: Dictionary<String, Double>
    
    init(_ item: FeedItem) {
        self.item = item
        self.sightingDict = createSightingDict(item.sightingInformation)
    }
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(color)
                .opacity(opacity)
                .aspectRatio(2.5, contentMode: .fit)
                .drawingGroup()
                
            HStack {
                if let routeNr = item.route?.nr {
                    Text("\(routeNr)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(width: 95)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                } else {
                    Image(systemName: "figure.wave")
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                        .frame(width: 95)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
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
                
                UporDownView(rating: item.voteScore)
            }
            .drawingGroup()
        }
        .padding(.horizontal)
        .shadow(radius: 15)
    }
}










struct FeedItemView_Previews: PreviewProvider {
    static var previews: some View {
        let item = FeedItem(route: (3, "Lohove mot sentrum"), stop: "Kongens gate", author: UUID(), location: CLLocationCoordinate2D(), 12, description: "")
        
        FeedItemView(item)
    }
}












