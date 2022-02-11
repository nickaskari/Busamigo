//
//  UporDownView.swift
//  Busamigo
//
//  Created by Nick Askari on 10/02/2022.
//

import SwiftUI

struct UporDownView: View {
    let rating: String
    
    var body: some View {
        VStack {
            Image(systemName: "arrow.up")
                .font(.system(size: 30))
                .foregroundColor(.mint)
                .padding(.bottom)
            Text("\(rating)")
                .foregroundColor(.white)
                .font(.title2.bold())
                .padding(.bottom)
            Image(systemName: "arrow.down")
                .font(.system(size: 30))
                .foregroundColor(.red)
        }
        .padding(30)
    }
}















struct UporDownView_Previews: PreviewProvider {
    static var previews: some View {
        UporDownView(rating: "13")
    }
}
