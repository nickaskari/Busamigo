//
//  TestLaunchView.swift
//  Busamigo
//
//  Created by Nick Askari on 06/07/2022.
//

import SwiftUI

struct TestLaunchView: View {
    var body: some View {
        ZStack {
            Color.pink.ignoresSafeArea()
            
            Image("Sombrero")
                .resizable()
                .frame(width: 200, height: 200)
                .aspectRatio(contentMode: .fit)
            
            ZStack {
                Text("BUSAMIGO")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
            }
            .offset(y: 150)
        }
    }
}








struct TestLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        TestLaunchView()
    }
}
