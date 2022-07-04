//
//  AddFeedItemView.swift
//  Busamigo
//
//  Created by Nick Askari on 17/02/2022.
//

import SwiftUI
import Combine

struct PostObservationView: View {
    @ObservedObject private var feed: AtbFeed
    @ObservedObject private var locationManager: LocationManager
    @ObservedObject private var postingManager: PostingManager
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var popUpManager: PopUpManager
    @EnvironmentObject private var userManager: UserManager
    
    @State private var description: String = ""
    @State private var placeholder: String = "Skriv en beskrivelse ..."
    @State private var notInArea: Bool = false
    @State private var redundantPost: Bool = false
    private let textLimit = 80
    
    init(_ feed: AtbFeed, _ locationManager: LocationManager, _ postingManager: PostingManager) {
        self.feed = feed
        self.locationManager = locationManager
        self.postingManager = postingManager
    }
    
    var body: some View {
       
        GeometryReader { geometry in
            ZStack {
                VStack {
                    ZStack(alignment: .leading) {
                        if self.description.isEmpty {
                            TextEditor(text: $placeholder)
                                .font(.body)
                                .foregroundColor(.gray)
                                .disabled(true)
                        }
                        ZStack {
                            TextEditor(text: $description)
                                .onReceive(Just(description)) { _ in limitText(textLimit) }
                            .opacity(self.description.isEmpty ? 0.25 : 1)
                        }
                    }
                    .frame(height: geometry.size.height * 0.08)
                    .padding(.top)
                    .padding(.horizontal, 30)
                    
                    Divider().padding(.horizontal)
                    
                    VStack {
                        Text("Din observasjon..")
                            .font(.headline)
                        postingManager.getPreview()
                            .disabled(true)
                    }
                    .frame(height: geometry.size.height * 0.4)
                }
            }
        }
        .background(.white)
        .onTapGesture {
            hideKeyboard()
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
            
            ToolbarItem(placement: .principal) {
                navigationTitle
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                shareButton
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.pink)
                .font(.system(size: 20))
        })
    }
    
    private var navigationTitle: some View {
        HStack {
            Image(systemName: "bonjour")
                .font(.system(size: 23))
                .shadow(radius: 1)
                .foregroundColor(.pink)
            Text("Del observasjon")
                .font(.bold(.title3)())
        }
    }
    
    private var shareButton: some View {
        Button (action: {
            if let loc = locationManager.lastKnownLocation {
                if loc.isInsideArea(feed.area) {
                    postingManager.setFeedItem(description: description, userID: userManager.getUserID())
                    feed.postToFeed(postingManager.getFeedItem()!) { success in
                        if success {
                            popUpManager.returnTofeed()
                        } else {
                            redundantPost.toggle()
                        }
                    }
                } else {
                    notInArea.toggle()
                }
            } else {
                popUpManager.returnTofeed()
            }
        }, label: {
            Text("Del")
        })
        .alert("Du befinner deg utenfor gyldig område!", isPresented: $notInArea) {
            Button("Skjønner!", role: .cancel) {
                popUpManager.returnTofeed()
            }
        } message: {
            Text("Gyldig området er rundt Trondheim.")
        }
        .alert("Denne observasjonen er nylig observert!", isPresented: $redundantPost) {
            Button("Skjønner!", role: .cancel) {
                popUpManager.returnTofeed()
            }
        } message: {
            Text("Prøv å gi en upvote :)")
        }
    }
    
    //Function to keep text length in limits
    private func limitText(_ upper: Int) {
        let tok = description.components(separatedBy: "\n")
        let spaces = tok.count - 1
        
        if description.count > upper {
            description = String(description.prefix(upper))
        }
        else if spaces > 2 {
            description.removeLast()
        }
    }
}







struct AddFeedItemView_Previews: PreviewProvider {
    static var previews: some View {
        PostObservationView(AtbFeed(), LocationManager(), PostingManager())
    }
}
