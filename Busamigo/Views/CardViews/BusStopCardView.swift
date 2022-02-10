//
//  BusStopCardView.swift
//  Busamigo
//
//  Created by Nick Askari on 10/02/2022.
//

import SwiftUI

struct BusStopCardView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.blue)
                .opacity(1)
                .aspectRatio(2, contentMode: .fit)
            
            HStack {
                Image(systemName: "bus")
                    .font(.system(size: 30))
                    .padding(.horizontal)
                    .colorInvert()
                VStack {
                    //Gjøre dette på en bedre måte
                    Text("Kongens Gate K1")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                        .foregroundColor(.white)
                    Text("1732        ")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                        .foregroundColor(.white)
                        .opacity(0.8)
                }
                Spacer()
                UporDownView(rating: "34")
            }
        }
        .padding(.horizontal)
    }
}




























struct BusStopCardView_Previews: PreviewProvider {
    static var previews: some View {
        BusStopCardView()
    }
}
