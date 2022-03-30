//
//  BusView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI

struct BusView: View {
    let rating: Int
    let sighting: String
    
    var body: some View {
        FeedItemView(color: Color(red: 0.15, green: 0.15, blue: 0.15), opacity: 1, isBus: true, rating: rating, sighting: sighting)
    }
}





































struct BusView_Previews: PreviewProvider {
    static var previews: some View {
        BusView(rating: 89, sighting: "Lohove 3:Hospitalkirka:2022")
    }
}
