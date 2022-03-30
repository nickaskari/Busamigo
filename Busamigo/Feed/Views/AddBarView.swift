//
//  AddBarView.swift
//  Busamigo
//
//  Created by Nick Askari on 26/03/2022.
//

import SwiftUI

struct AddBarView: View {
    @ObservedObject var addManager: AddViewManager
    
    init(_ addManager: AddViewManager) {
        self.addManager = addManager
    }
    
    var body: some View {
        HStack(alignment: .center) {
            
            Button(action: {
                withAnimation(addManager.getAnimation()) {
                    addManager.dontshow()
                }
            }, label: {
                Text("Avbryt")
                    .padding()
                    .foregroundColor(.black)
            })
            
            
            Spacer()
            
            Image(systemName: "bonjour")
                .font(.system(size: 23))
                .shadow(radius: 1)
                .foregroundColor(.pink)
            Text("Del observasjon")
                .font(.bold(.title3)())
            
            Spacer()
            
            Button(action: {
                addManager.show()
            }, label: {
                Text("Legg til")
                    .padding()
            })
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct AddBarView_Previews: PreviewProvider {
    static var previews: some View {
        AddBarView(AddViewManager())
    }
}
