//
//  PreferanceView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import SwiftUI



struct PreferanceView: View {
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing:0) {
                    PreferanceBoxView(preferance: "Relevant", isPressed: true)
                    PreferanceBoxView(preferance: "Trikk", isPressed: false)
                    PreferanceBoxView(preferance: "Buss", isPressed: false)
                    PreferanceBoxView(preferance: "Rating", isPressed: false)
                    PreferanceBoxView(preferance: "Lokasjon", isPressed: false)
                }
            }
            .aspectRatio(6, contentMode: .fit)
    }
}


private struct PreferanceBoxView: View {
    let preferance: String
    @State var isPressed: Bool
    private var buttonOpacity: Double {
        if isPressed {
            return 0.8
        }
        else {
            return 0
        }
    }
    
    let colorTheme: Color = Color.init(red: 0.1, green: 0.1, blue: 0.1)
    
    private var textColor: Color {
        if isPressed {
            return .white
        }
        else {
            return self.colorTheme
        }
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.easeIn(duration: 0.1)) {
                isPressed.toggle()
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .strokeBorder(self.colorTheme, lineWidth: 2)
                    .opacity(0.5)
                    .background(RoundedRectangle(cornerRadius: 50)
                                    .foregroundColor(self.colorTheme)
                                    .opacity(buttonOpacity))
                    .aspectRatio(2, contentMode: .fit)
                    .padding(10)
                Text("\(preferance)")
                    .foregroundColor(textColor)
                    .font(.headline)
            }
        })
    }
}















struct PreferanceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferanceView()
    }
}
