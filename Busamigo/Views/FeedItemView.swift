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
            HStack {
                BusLineView()
                //UpDownVoteView()
            }
            //.padding(10)
        }
        .padding()
    }
}

struct BusLineView: View {
   
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
                VStack {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 30))
                        .foregroundColor(.mint)
                        .padding(.bottom)
                    Text("12")
                        .foregroundColor(.white)
                        .font(.title2.bold())
                        .padding(.bottom)
                    Image(systemName: "arrow.down")
                        .font(.system(size: 30))
                        .foregroundColor(.red)
                }
                .padding(.leading, 90)
            }
            
        }
    }
}

struct UpDownVoteView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .opacity(0.2)
                .aspectRatio(0.1, contentMode: .fit)
        }
    }
}

































struct FeedItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeedItemView()
    }
}
