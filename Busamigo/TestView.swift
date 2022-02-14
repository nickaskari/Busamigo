//
//  TestView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import SwiftUI

struct TestView: View {
    @State private var showDetails = false

        var body: some View {
            VStack {
                Button("Press to show details") {
                    withAnimation {
                        showDetails.toggle()
                    }
                }

                if showDetails {
                    // Moves in from the bottom
                    Text("Details go here.")
                        .transition(.move(edge: .top))

                    
                }
            }
        }
}






struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
