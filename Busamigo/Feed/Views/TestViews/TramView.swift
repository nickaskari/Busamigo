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
        FeedItemView(rating: rating, sighting: sighting, vehicle: "tram")
    }
}













