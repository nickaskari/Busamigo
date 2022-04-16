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
    @ObservedObject var atbFeed: AtbFeed
    @ObservedObject var locationManager: LocationManager
    @Environment(\.scenePhase) var scenePhase
    
    init(feed: AtbFeed, _ locationManager: LocationManager) {
        self.atbFeed = feed
        self.locationManager = locationManager
    }
    //automatically change the view when one has given access to the location
    
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { value in
                    HStack(spacing: 0) {
                        ForEach(atbFeed.getFilters(), id: \.description) { filter in
                            
                            Button(action: {
                                withAnimation {
                                    value.scrollTo(filter)
                                }
                                getTapticFeedBack(style: .medium)
                                withAnimation(.linear(duration: 0.001)) {
                                    if filter == "Lokasjon" {
                                        displayLocationFilter()
                                    } else {
                                        atbFeed.disableLocationError()
                                        atbFeed.activateFilter(filter, userLon: nil, userLat: nil)
                                    }
                                }
                            }, label: {
                                FilterBoxView(filter, isPressed: atbFeed.isFilterOn(filter))
                            })
                            .id(filter)
                            .onAppear {
                                if atbFeed.isFilterOn(filter) {
                                    value.scrollTo(filter)
                                }
                            }
                        }
                    }
                }
            }
            .background(.ultraThinMaterial)
            .padding(.bottom, 5)
            .aspectRatio(8, contentMode: .fit)
            .onChange(of: scenePhase) { newPhase in
                    if newPhase == .active {
                        locationManager.checkIfLocationServicesIsEnabled()
                        if atbFeed.isFilterOn("Lokasjon") {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                displayLocationFilter()
                            }
                        }
                    }
            }
    }
    
    private func hasError() -> Bool {
        return atbFeed.getLocationError(locationManager.errors) != nil
    }
    
    private func updateLocationError() {
        locationManager.checkIfLocationServicesIsEnabled()
        
        if hasError() {
            atbFeed.alertLocationError()
         
        } else {
            atbFeed.disableLocationError()
        }
    }
    
    private func displayLocationFilter() {
        updateLocationError()
        
        if !hasError() {
            if let loc = locationManager.lastKnownLocation {
                atbFeed.activateFilter("Lokasjon", userLon: loc.longitude, userLat: loc.latitude)
            }
            //handle if last location couldnt be found
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
                .aspectRatio(2, contentMode: .fit)
                .padding(5)
            Text("\(preferance)")
                .foregroundColor(textColor)
                .font(.subheadline)
                .padding(15)
                .scaledToFit()
        }
    }
}















struct PreferanceView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(feed: AtbFeed(), LocationManager())
    }
}
