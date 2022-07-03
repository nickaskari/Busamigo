//
//  EmptyFeedView.swift
//  Busamigo
//
//  Created by Nick Askari on 03/06/2022.
//

import SwiftUI

struct EmptyFeedView: View {
    
    var body: some View {
            
        Text("Ingen observasjoner idag :)")
            .foregroundColor(.gray)
            .font(.title2)
            .padding()
    }
}










struct EmptyFeedView___Previews: PreviewProvider {
    static var previews: some View {
        EmptyFeedView()
    }
}
