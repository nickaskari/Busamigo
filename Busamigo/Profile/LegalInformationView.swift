//
//  LegalInformationView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI

struct LegalInformationView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("info")
            Spacer()
        }
        .navigationTitle("Personvern")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutBusamigoView_Previews: PreviewProvider {
    static var previews: some View {
        LegalInformationView()
    }
}
