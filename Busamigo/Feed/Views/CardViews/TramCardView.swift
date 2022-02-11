//
//  TramCardView.swift
//  Busamigo
//
//  Created by Nick Askari on 10/02/2022.
//

import SwiftUI

struct TramCardView: View {
    let rating: Int
    let sighting: String
    
    var body: some View {
        CardView(color: .black, opacity: 0.7, isBus: false, rating: rating, sighting: sighting)
    }
}














struct TramCardView_Previews: PreviewProvider {
    static var previews: some View {
        TramCardView(rating: -3, sighting: "Lian 1:Munkholmen:1512")
    }
}
