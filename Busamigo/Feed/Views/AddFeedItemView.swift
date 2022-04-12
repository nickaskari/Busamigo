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
    @State private var placeholder: String = "Skriv beskrivelse.."
    
    let textLimit = 80 //Your limit
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
       
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        AddBarView(presentationMode: _presentationMode)
                            
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
                        
                        NavigationLink(destination: StopSearchView()) {
                            HStack {
                                Image(systemName: "figure.wave")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                                Text("Legg til holdeplass")
                                    .foregroundColor(.black)
                                    .font(.body)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal, 30)
                        }
                        Divider().padding(.horizontal)
                        NavigationLink(destination: RouteSearchView()) {
                            HStack {
                                Image(systemName: "bus")
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                                Text("Legg til buss/trikk")
                                    .foregroundColor(.black)
                                    .font(.body)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal, 30)
                        }
                        
                        VStack {
                            Text("Din observasjon..")
                                .font(.headline)
                            FeedItemView(color: Color(red: 0.15, green: 0.15, blue: 0.15), opacity: 1, isBus: true, rating: 0, sighting: "Buss 3;jallastop;16:45")
                        }
                        .frame(height: geometry.size.height * 0.4)
                    }
                }
            }
            .background(.white)
            .accentColor(.pink)
            .cornerRadius(20, corners: .topRight)
            .cornerRadius(20, corners: .topLeft)
            .shadow(radius: 10)
            .padding(.top, 55)
            .onTapGesture {
                hideKeyboard()
            }
            .edgesIgnoringSafeArea(.all)
        }
        .accentColor(.pink)
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
        AddFeedItemView()
    }
}
