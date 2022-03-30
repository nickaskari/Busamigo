//
//  StopSearchView.swift
//  Busamigo
//
//  Created by Nick Askari on 27/03/2022.
//

import SwiftUI

struct StopSearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        Text("Searching for \(searchText)")
                .searchable(text: $searchText, prompt: "Søk holdeplasser")
                .navigationBarTitle("Legg til holdeplass")
    }
}

struct StopsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        StopSearchView()
    }
}
