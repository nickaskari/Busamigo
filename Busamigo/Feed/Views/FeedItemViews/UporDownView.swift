//
//  UporDownView.swift
//  Busamigo
//
//  Created by Nick Askari on 24/05/2022.
//

import SwiftUI

struct UporDownView: View {
    @AppStorage("userID") var userID: UUID?
    
    let rating: String
    
    var body: some View {
        VStack {
            Button(action: {
                getTapticFeedBack(style: .medium)
                print("opp")
            }, label: {
                Image(systemName: "chevron.up")
                    .font(.system(size: 30))
                    .foregroundColor(.mint)
            })
            .buttonStyle(PoppingButtonStyle3())
            
            Text("\(rating)")
                .foregroundColor(.white)
                .font(.title2)
                .padding(.top, 20)
                .padding(.bottom, 20)
            
            Button(action: {
                getTapticFeedBack(style: .medium)
                print("ned")
            }, label: {
                Image(systemName: "chevron.down")
                    .font(.system(size: 30))
                    .foregroundColor(.red)
            })
            .buttonStyle(PoppingButtonStyle3())
        }
        .padding(30)
    }
}

struct UporDownView_Previews: PreviewProvider {
    static var previews: some View {
        UporDownView(rating: "12")
    }
}
