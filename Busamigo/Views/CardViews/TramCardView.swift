//
//  TramCardView.swift
//  Busamigo
//
//  Created by Nick Askari on 10/02/2022.
//

import SwiftUI

struct TramCardView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.black)
                .opacity(0.8)
                .aspectRatio(2, contentMode: .fit)
            
            HStack {
                Image(systemName: "tram")
                    .font(.system(size: 30))
                    .padding(.horizontal)
                    .colorInvert()
                VStack {
                    //Gjøre dette på en bedre måte
                    Text("Lian 1           ")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                        .foregroundColor(.white)
                    Text("Munkvoll     ")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                        .foregroundColor(.white)
                        .opacity(0.8)
                    Text("1015             ")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                        .foregroundColor(.white)
                        .opacity(0.6)
                }
                Spacer()
                UporDownView(rating: "-3")
            }
        }
        .padding(.horizontal)
    }
}














struct TramCardView_Previews: PreviewProvider {
    static var previews: some View {
        TramCardView()
    }
}
