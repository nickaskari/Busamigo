//
//  FeedItemView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI

struct BusCardView: View {
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.black)
                .opacity(0.7)
                .aspectRatio(2, contentMode: .fit)
            
            HStack {
                Image(systemName: "bus")
                    .font(.system(size: 30))
                    .padding(.horizontal)
                    .colorInvert()
                VStack {
                    //Gjøre dette på en bedre måte
                    Text("Lohove 3")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                        .foregroundColor(.white)
                    Text("Hallset     ")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                        .foregroundColor(.white)
                        .opacity(0.8)
                    Text("1645        ")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                        .foregroundColor(.white)
                        .opacity(0.6)
                }
                Spacer()
                UporDownView(rating: "12")
            }
        }
        .padding()
    }
}





































struct FeedItemView_Previews: PreviewProvider {
    static var previews: some View {
        BusCardView()
    }
}
