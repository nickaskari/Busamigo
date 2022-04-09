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
    //TODO: Tilknytning til ViewModels
    @ObservedObject var atbFeed: AtbFeed
    //Create some viewmodel for appbar to add feed thing
    @ObservedObject var addManager: AddViewManager
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @State private var hideBar: Bool = false
    @State var selectedModel: DetailView? = nil
    
    init(_ addManager: AddViewManager, feed: AtbFeed) {
        self.addManager = addManager
        self.atbFeed = feed
    }
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    AppBarView()
                    if !hideBar {
                        FilterView(atbFeed)
                    }
                    Divider()
                    ZStack() {
                        ScrollView(.vertical) {
                            VStack(spacing: 0) {
                                
                                ForEach(atbFeed.getFeed()) { item in
                                    
                                    Button(action: {
                                        selectedModel = DetailView(description: item.sightingInformation, location: item.location)
                                    }, label: {
                                        if item.transportVehicle == "bus" {
                                            BusView(rating: item.voteRating, sighting: item.sightingInformation)
                                        }
                                        else if item.transportVehicle == "tram" {
                                            TramView(rating: item.voteRating, sighting: item.sightingInformation)
                                        }
                                    })
                                    .buttonStyle(FeedItemButtonStyle())
                                    .sheet(item: $selectedModel) { model in
                                        NextScreenView(selectedModel: model)
                                    }
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
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(self.addManager.getAnimation()) {
                            self.addManager.show()
                        }
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
                        .animation(.easeOut.speed(1.5), value: 2)
                }
            } //ZSTACK
        }
    }
}







struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(AddViewManager(), feed: AtbFeed())
    }
}
