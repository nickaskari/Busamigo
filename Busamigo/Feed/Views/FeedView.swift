//
//  FeedView.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI
import MapKit

struct FeedView: View {
    @ObservedObject var atbFeed: AtbFeed
    @ObservedObject var locationManager: LocationManager
    
    private var scrollFeed: ScrollFeedView
    @State private var isPresented = false
    
    init(feed: AtbFeed, _ locationManager: LocationManager) {
        self.atbFeed = feed
        self.locationManager = locationManager
        self.scrollFeed = ScrollFeedView(feed)
    }
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    AppBarView()
                    if atbFeed.isShowingBar() {
                        FilterView(feed: atbFeed, locationManager)
                    }
                    Divider()
                        .background(.ultraThinMaterial)
                    ZStack(alignment: .top) {
                        if atbFeed.isLocationError() {
                            let err = atbFeed.getLocationError(locationManager.errors)
                            LocationErrorView(error: err!)
                        } else {
                            scrollFeed
                                .edgesIgnoringSafeArea(.top)
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
