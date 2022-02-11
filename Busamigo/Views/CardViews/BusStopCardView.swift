//
//  BusStopCardView.swift
//  Busamigo
//
//  Created by Nick Askari on 10/02/2022.
//

import SwiftUI

struct BusStopCardView: View {
    let rating: Int
    let sighting: String
    
    var body: some View {
        CardView(color: .blue, opacity: 1, isBus: true, rating: rating, sighting: sighting)
    }
}




























struct BusStopCardView_Previews: PreviewProvider {
    static var previews: some View {
        BusStopCardView(rating: 21, sighting: "Kongens Gate 1:1721")
    }
}
