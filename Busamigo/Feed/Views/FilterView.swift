//
//  FilterView.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import SwiftUI
import MapKit
import CoreLocationUI


struct FilterView: View {
    @ObservedObject private var feed: AtbFeed
    @ObservedObject private var locationManager: LocationManager
    @EnvironmentObject private var scrollManager: ScrollManager
    @Environment(\.scenePhase) private var scenePhase
    
    @State var unableToGetLocation: Bool = false
    
    init(feed: AtbFeed, _ locationManager: LocationManager) {
        self.feed = feed
        self.locationManager = locationManager
    }
    
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { value in
                    HStack(spacing: 0) {
                        ForEach(feed.getFilters(), id: \.description) { filter in
                            
                            Button(action: {
                                withAnimation {
                                    value.scrollTo(filter)
                                }
                                getTapticFeedBack(style: .light)
               
                                if filter == "Lokasjon" {
                                    if !locationManager.displayLocationFilter(feed) {
                                        unableToGetLocation.toggle()
                                    }
                                } else {
                                    feed.disableLocationError()
                                    feed.activateFilter(filter, userLon: nil, userLat: nil)
                                }
                                
                            }, label: {
                                FilterBoxView(filter, isPressed: feed.isFilterOn(filter))
                            })
                            .alert(isPresented: $unableToGetLocation) {
                                Alert(title: Text("Busamigo finner ikke posisjonen din!"), message: Text("Prøv igjen ved et senere tidspunkt."), dismissButton: .default(Text("Skjønner!")))
                            }
                            .id(filter)
                            .onReceive(feed.objectWillChange) { out in
                                if feed.isFilterOn(filter) {
                                    withAnimation {
                                        value.scrollTo(filter)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .background(.ultraThinMaterial)
            .aspectRatio(9, contentMode: .fit)
            .onChange(of: scenePhase) { newPhase in
                    if newPhase == .active {
                        if feed.isFilterOn("Lokasjon") {
                            locationManager.displayLocationFilter(feed)
                        }
                    }
            }
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
    
    let colorTheme: Color = Color.init(red: 0.02, green: 0.02, blue: 0.02)
    
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
                .strokeBorder(colorTheme, lineWidth: 2)
                .opacity(0.5)
                .background(RoundedRectangle(cornerRadius: 50)
                                .foregroundColor(self.colorTheme)
                                .opacity(buttonOpacity))
                .padding(7)
                .aspectRatio(2, contentMode: .fit)
            Text("\(preferance)")
                .foregroundColor(textColor)
                .font(.subheadline)
                .scaledToFit()
        }
    }
}















struct PreferanceView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(feed: AtbFeed(), LocationManager())
    }
}
