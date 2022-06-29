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
                .capsuleStyle(.pink, size: .medium)
                .padding(15)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            self.showError = false
                        }
                    }
                }
        }
    }
}

struct NetworkErrorView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkErrorView()
    }
}
