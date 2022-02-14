//
//  TramView.swift
//  Busamigo
//
//  Created by Nick Askari on 10/02/2022.
//

import SwiftUI

struct TramView: View {
    let rating: Int
    let sighting: String
    
    var body: some View {
        FeedItemView(color: .black, opacity: 0.78, isBus: false, rating: rating, sighting: sighting)
    }
}














struct TramView_Previews: PreviewProvider {
    static var previews: some View {
        TramView(rating: -3, sighting: "Lian 1:Munkholmen:1512")
    }
}
