//
//  NetworkErrorView.swift
//  Busamigo
//
//  Created by Nick Askari on 30/06/2022.
//

import SwiftUI

struct NetworkErrorView: View {
    @State private var showError: Bool = true
    
    var body: some View {
        if showError {
            Text("Ops! Ingen internet-tilkobling")
                .capsuleStyle(.pink, size: .small)
                .padding(15)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation {
                            self.showError = false
                        }
                    }
                }
                .position(x: UIScreen.screenWidth / 2, y: 45)
        }
    }
}

struct NetworkErrorView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkErrorView()
    }
}
