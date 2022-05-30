//
//  AddFeedItemView.swift
//  Busamigo
//
//  Created by Nick Askari on 17/02/2022.
//

import SwiftUI
import Combine

struct AddFeedItemView: View {
    @State private var description: String = ""
    @State private var placeholder: String = "Skriv en beskrivelse ..."
    @ObservedObject var feed: AtbFeed
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var postingManager: PostingManager
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var popUpManager: PopUpManager
    let textLimit = 80
    
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
                        TextEditor(text: $description)
                            .onReceive(Just(description)) { _ in limitText(textLimit) }
                            .opacity(self.description.isEmpty ? 0.25 : 1)
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
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.pink)
                        .font(.system(size: 20))
                })
            }
            
            ToolbarItem(placement: ToolbarItemPlacement.principal) {
                HStack {
                    Image(systemName: "bonjour")
                        .font(.system(size: 23))
                        .shadow(radius: 1)
                        .foregroundColor(.pink)
                    Text("Del observasjon")
                        .font(.bold(.title3)())
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button (action: {
                    postingManager.setFeedItem()
                    postingManager.addDescription(description)
                    feed.postToFeed(postingManager.getFeedItem()!, getUser()!)
                    popUpManager.returnTofeed()
                }, label: {
                    Text("Del")
                })
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    //Function to keep text length in limits
    func limitText(_ upper: Int) {
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
        AddFeedItemView(AtbFeed(), LocationManager(), PostingManager())
    }
}
