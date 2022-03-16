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
        FeedItemView(color: Color(red: 0.15, green: 0.15, blue: 0.15), opacity: 1, isBus: false, rating: rating, sighting: sighting)
    }
}














struct TramView_Previews: PreviewProvider {
    static var previews: some View {
        TramView(rating: -3, sighting: "Lian 1:Munkholmen:1512")
    }
}
