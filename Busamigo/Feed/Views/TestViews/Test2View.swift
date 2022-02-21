//
//  Test2View.swift
//  Busamigo
//
//  Created by Nick Askari on 18/02/2022.
//

import SwiftUI

struct Test2View: View {
    let names = ["Holly", "Josh", "Rhonda", "Ted"]
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { name in
                    NavigationLink(destination: Text(name)) {
                        Text(name)
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Contacts")
        }
    }

    var searchResults: [String] {
        if searchText.isEmpty {
            return [""]
        } else {
            return names.filter { $0.contains(searchText) }
        }
    }
}











struct Test2View_Previews: PreviewProvider {
    static var previews: some View {
        Test2View()
    }
}
