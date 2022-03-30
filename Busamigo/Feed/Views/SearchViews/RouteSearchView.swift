//
//  RouteSearchView.swift
//  Busamigo
//
//  Created by Nick Askari on 27/03/2022.
//

import SwiftUI

struct RouteSearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        Text("Searching for \(searchText)")
                .searchable(text: $searchText, prompt: "Søk buss/trikk")
                .navigationBarTitle("Legg til buss/trikk")
    }
}

struct RouteSearchView_Previews: PreviewProvider {
    static var previews: some View {
        RouteSearchView()
    }
}
