//
//  UporDownView.swift
//  Busamigo
//
//  Created by Nick Askari on 24/05/2022.
//

import SwiftUI

struct UporDownView: View {
    @AppStorage("userID") var userID: UUID?
    
    let rating: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                getTapticFeedBack(style: .medium)
                print("opp")
            }, label: {
                Image(systemName: "chevron.up")
                    .font(.system(size: 30))
                    .foregroundColor(.mint)
            })
            .buttonStyle(PoppingButtonStyle3())
            .fixedSize()
            
            Text("\(rating)")
                .foregroundColor(.white)
                .font(.title2)
            
            Button(action: {
                getTapticFeedBack(style: .medium)
                print("ned")
            }, label: {
                Image(systemName: "chevron.down")
                    .font(.system(size: 30))
                    .foregroundColor(.red)
            })
            .buttonStyle(PoppingButtonStyle3())
            .fixedSize()
        }
        .frame(width: 95)
    }
}







struct UporDownView_Previews: PreviewProvider {
    static var previews: some View {
        UporDownView(rating: 12)
    }
}
