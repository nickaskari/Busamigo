//
//  FeedItemView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI

struct FeedItemView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.green, lineWidth: 5)
                .frame(width: 350, height: 150, alignment: .center)
                .padding()
            HStack {
                RoundedRectangle(cornerRadius: 20)
                    .scaledToFit()
                    .padding(32)
                    .foregroundColor(.black)
                    .opacity(0.0)
                BusLineView()
            }
        }
    }
}

struct BusLineView: View {
   
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .scaledToFit()
                .padding(32)
                .foregroundColor(.black)
                .opacity(0.7)
            Text("Lohove \n      3")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(20)
        }
    }
}

































struct FeedItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeedItemView()
    }
}
