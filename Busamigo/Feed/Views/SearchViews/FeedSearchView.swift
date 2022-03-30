//
//  FeedSearchView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import SwiftUI

struct FeedSearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        Text("Searching for \(searchText)")
                .searchable(text: $searchText, prompt: "Søk buss/trikk eller holdeplasser")
                .navigationBarTitle("Custom feed")
    }
}

struct FeedSearchView_Previews: PreviewProvider {
    static var previews: some View {
        FeedSearchView()
    }
}
