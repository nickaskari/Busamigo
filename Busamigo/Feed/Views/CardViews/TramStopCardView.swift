//
//  TramStopCardView.swift
//  Busamigo
//
//  Created by Nick Askari on 11/02/2022.
//

import SwiftUI

struct TramStopCardView: View {
    let rating: Int
    let sighting: String
    
    var body: some View {
        CardView(color: .indigo, opacity: 1, isBus: false, rating: rating, sighting: sighting)
    }
}

struct TramStopCardView_Previews: PreviewProvider {
    static var previews: some View {
        TramStopCardView(rating: 2, sighting: "Rognheim:0902")
    }
}
