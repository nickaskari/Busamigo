//
//  FeedView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI

struct FeedView: View {
    //TODO: Tilknytning til ViewModels
    //Create some viewmodel for appbar to add feed thing
    @ObservedObject var addManager: AddViewManager
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @State private var hideBar: Bool = false
    
    init(_ addManager: AddViewManager) {
        self.addManager = addManager
    }
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    AppBarView(self.addManager)
                    if !hideBar {
                        PreferanceView()
                    }
                    Divider()
                    ZStack() {
                        ScrollView(.vertical) {
                            VStack(spacing: 0) {
                                
                                ForEach(0..<7) { item in
                                    BusView(rating: 89, sighting: "Lohove 3;Hospitalkirka;20:22")
                                    BusView(rating: 21, sighting: "Kongens Gate 1;17:21")
                                    BusView(rating: 89, sighting: "Tyholt via Sentrum 20;Høgskoleringen;19:21")
                                    TramView(rating: -3, sighting: "Lian 1;Munkholmen;15:12")
                                    TramView(rating: 2, sighting: "Rognheim;09:02")
                                }
                            }
                            .overlay (
                                GeometryReader { proxy -> Color in
                                    
                                    let minY = proxy.frame(in: .named("SCROLL")).minY
                                    let scrollHeight = proxy.frame(in: .named("SCROLL")).height
                                    
                                    let durationOffset: CGFloat = 10
                                    
                                    DispatchQueue.main.async {
                                        
                                        if minY < offset {
                                            if offset < 0 && -minY > (lastOffset + durationOffset) {
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
                .onTapGesture {
                    withAnimation(self.addManager.getAnimation()) {
                        self.addManager.dontshow()
                    }
                    UIScrollView.appearance().bounces = true
                }
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(self.addManager.getAnimation()) {
                            self.addManager.show()
                            UIScrollView.appearance().bounces = false
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
            .background(.ultraThinMaterial)
        }
    }
}







struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(AddViewManager())
    }
}
