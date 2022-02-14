//
//  FeedView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI

struct FeedView: View {
    //TODO: Tilknytning til ViewModels
    @State private var showBar: Bool = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if showBar {
                    MenuBarView()
                }
                PreferanceView()
                Divider()
                ZStack(alignment: .bottom) {
                    ScrollView(.vertical) {
                        //Foreløpig
                        VStack(spacing: 0) {
                            
                            GeometryReader { reader -> AnyView in
                                
                                let yAxis = reader.frame(in: .global).minY
                                
                                if yAxis < 0 && showBar {
                                    DispatchQueue.main.async {
                                        withAnimation(Animation.linear(duration: 0.1)) {
                                            self.showBar = false
                                        }
                                    }
                                }
                                if yAxis > 0 && !showBar {
                                    DispatchQueue.main.async {
                                        withAnimation(Animation.linear(duration: 0.1)) {
                                            self.showBar = true
                                        }
                                    }
                                }
                                return AnyView(
                                    Text("")
                                        .frame(width: 0, height: 0)
                                )
                            }
                            .frame(width: 0, height: 0)
                            
                            ForEach(0..<7) { item in
                                BusView(rating: 89, sighting: "Lohove 3:Hospitalkirka:2022")
                                BusView(rating: 21, sighting: "Kongens Gate 1:1721")
                                BusView(rating: 89, sighting: "Tyholt via Sentrum 20:Høgskoleringen:1921")
                                TramView(rating: -3, sighting: "Lian 1:Munkholmen:1512")
                                TramView(rating: 2, sighting: "Rognheim:0902")
                            }
                        }
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 75))
                                    .background(alignment: .center) {
                                        Color.white
                                            .mask(Circle())
                                    }
                                    .shadow(radius: 2)
                                    .foregroundColor(.pink)
                            }
                        }
                        .frame(width: 60, height: 60)
                        .padding(30)
                    }
                }
            }
        }
    }
}







struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
