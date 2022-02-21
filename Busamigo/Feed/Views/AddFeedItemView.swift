//
//  AddFeedItemView.swift
//  Busamigo
//
//  Created by Nick Askari on 17/02/2022.
//

import SwiftUI

struct AddFeedItemView: View {
    @State private var route: String = ""
    @State private var stop: String = ""
    @State private var description: String = ""
    @ObservedObject var addManager: AddViewManager
    
    init(_ addManager: AddViewManager) {
        self.addManager = addManager
        preview.show()
    }
    
    var body: some View {
        if self.addManager.isShowingAddPage() {
            GeometryReader { geometry in
                NavigationView {
                    ZStack(alignment: .bottom) {
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 0)
                                .foregroundColor(.white)
                            TextField("Skriv beskrivelse..", text: $description)
                                .padding(40)
                                .font(.title)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 40)
                                .foregroundColor(.black)
                                .aspectRatio(1.7, contentMode: .fit)
                                .shadow(radius: 5)
                                .opacity(0.85)
                            HStack {
                                VStack {
                                    Image(systemName: "figure.wave")
                                        .font(.system(size: 40))
                                        .foregroundColor(.pink)
                                        .padding(.horizontal, 60)
                                        .padding(.bottom)
                                    Text("Legg til holdeplass")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                }
                                VStack {
                                    Image(systemName: "bus")
                                        .font(.system(size: 40))
                                        .foregroundColor(.pink)
                                        .padding(.horizontal, 60)
                                        .padding(.bottom)
                                    Text("Legg til buss/trikk")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                    .accentColor(.pink)
                    .navigationBarTitle("Legg til observasjon🌍", displayMode: .large).toolbar(content: {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(action: {
                                UIScrollView.appearance().bounces = true
                                withAnimation(self.addManager.getAnimation()) {
                                    self.addManager.dontshow()
                                }
                            }, label: {
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 20))
                            })
                                .foregroundColor(.black)
                        }
                    })
                }
                .edgesIgnoringSafeArea(.all)
                .frame(width: geometry.size.width * 1, height: geometry.size.height * 1.1, alignment: .top)
                .cornerRadius(30, corners: .topRight)
                .cornerRadius(30, corners: .topLeft)
                .shadow(radius: 10)
            }
            .padding(.top, 55)
            .onTapGesture {
                hideKeyboard()
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
    
    struct AddButtonView: View {
        
        var body: some View {
            Text("Legg til")
                .bold()
                .padding(30)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 30).foregroundColor(.pink).aspectRatio(2, contentMode: .fit))
                .shadow(radius: 4)
        }
    }
}




var preview = AddViewManager()


struct AddFeedItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddFeedItemView(preview)
    }
}
