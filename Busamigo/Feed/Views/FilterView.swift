//
//  FilterView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import SwiftUI



struct FilterView: View {
    @ObservedObject var atbFeed: AtbFeed
    @ObservedObject var locationManager: LocationManager = LocationManager()
    
    init(_ atbFeed: AtbFeed) {
        self.atbFeed = atbFeed
    }
    
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing:0) {
                    ForEach(atbFeed.getFilters(), id: \.description) { filter in
                        
                        Button(action: {
                            withAnimation(.linear(duration: 0.001)) {
                                atbFeed.activateFilter(filter)
                            }
                        }, label: {
                            FilterBoxView(filter, isPressed: atbFeed.isFilterOn(filter))
                        })
                    }
                }
            }
            .aspectRatio(6, contentMode: .fit)
    }
}


private struct FilterBoxView: View {
    let preferance: String
    let isPressed: Bool
    
    init(_ preferance: String, isPressed: Bool) {
        self.preferance = preferance
        self.isPressed = isPressed
    }
    
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
    }
}















struct PreferanceView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(AtbFeed())
    }
}
