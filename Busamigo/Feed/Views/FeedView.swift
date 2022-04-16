//
//  FeedView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI
import MapKit

//onAppear, mekke alle lokasjoner, bruk det på sh

struct FeedView: View {
    @ObservedObject var atbFeed: AtbFeed
    @ObservedObject var locationManager: LocationManager
    
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @State private var hideBar: Bool = false
    @State private var isPresented = false
    
    init(feed: AtbFeed, _ locationManager: LocationManager) {
        self.atbFeed = feed
        self.locationManager = locationManager
    }
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    AppBarView()
                    if !hideBar {
                        FilterView(feed: atbFeed, locationManager)
                    }
                    Divider()
                        .background(.ultraThinMaterial)
                    ZStack {
                        if atbFeed.isLocationError() {
                            let err = atbFeed.getLocationError(locationManager.errors)
                            LocationErrorView(error: err!)
                        } else {
                            ScrollView(.vertical) {
                                LazyVStack(spacing: 5) {
                                    ForEach(atbFeed.getFeed()) { item in
                                        
                                        NavigationLink(destination: {
                                            DetailView(description: item.sightingInformation, location: item.location)
                                        }, label: {
                                            FeedItemView(rating: item.voteScore, sighting: item.sightingInformation, vehicle: item.transportVehicle)
                                        })
                                        .buttonStyle(PushDownButtonStyle())
                                    }
                                }
                                .overlay (
                                    GeometryReader { proxy -> Color in
                                        
                                        let minY = proxy.frame(in: .named("SCROLL")).minY
                                        let scrollHeight = proxy.frame(in: .named("SCROLL")).height
                                        
                                        let durationOffset: CGFloat = 10
                                        
                                        DispatchQueue.main.async {
                                            
                                            if minY < offset {
                                                if offset < 0 && -minY > (lastOffset + durationOffset) && (scrollHeight >= 1000) {
                                                    withAnimation(.easeOut.speed(2)) {
                                                        hideBar = true
                                                    }
                                                    
                                                    lastOffset = -offset
                                                }
                                                
                                            }
                                            if minY > offset && -minY < (lastOffset - durationOffset) &&
                                            (scrollHeight - -(minY)) >= 870 {
                                                withAnimation(.easeIn.speed(2)) {
                                                    hideBar = false
                                                }
                                                
                                                lastOffset = -offset
                                                
                                            }
                                            
                                            self.offset = minY
                                        }
                                        return Color.clear
                                    }
                                )
                            }
                            .coordinateSpace(name: "SCROLL")
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                        }
                    }
                }
                HStack {
                    Spacer()
                    Button(action: {
                        getTapticFeedBack(style: .medium)
                        isPresented.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .shadow(radius: 1)
                            .padding()
                            .foregroundColor(.white)
                            .font(.system(size: 50))
                            .background(Circle().foregroundColor(.pink))
                            .padding()
                            .shadow(radius: 5)
                    })
                    .buttonStyle(PoppingButtonStyle())
                    .fullScreenCover(isPresented: $isPresented, content: AddFeedItemView.init)
                }
            } //ZSTACK
        }
    }
}







struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(feed: AtbFeed(), LocationManager())
    }
}
