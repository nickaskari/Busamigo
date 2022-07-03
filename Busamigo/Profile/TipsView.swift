//
//  TipsView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI

struct TipsView: View {
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color(red: 0.12, green: 0.12, blue: 0.12))
            HStack {
                tipsText
                    .scaledToFit()
                Spacer()
                Image(systemName: "info.circle")
                    .foregroundColor(.white)
                    .font(.system(size: 40))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 40))
            }
        }
        .aspectRatio(1.8, contentMode: .fit)
        .padding()
        .shadow(radius: 10)
    }
    
    var tipsText: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Vil du øke din karisma?")
                .font(.headline)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 0))
            Text("Poste observasjoner, og \nfå upvotes!")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
            Text("Dårlige observasjoner kan koste\ndeg i downvotes, følgelig også\npå din karisma.")
                .font(.system(size: 14))
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
        }
    }
}


struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView()
    }
}
