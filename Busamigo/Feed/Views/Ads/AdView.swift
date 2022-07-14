//
//  AdView.swift
//  Busamigo
//
//  Created by Nick Askari on 14/07/2022.
//

import SwiftUI
import GoogleMobileAds

struct AdView: View {
    
    var body: some View {
        ZStack {
            ActivityIndicator(color: .pink)
            
            GADBannerViewController()
                .frame(width: GADAdSizeMediumRectangle.size.width, height: GADAdSizeMediumRectangle.size.height)
        }
        .padding()
    }
}













struct AdView_Previews: PreviewProvider {
    static var previews: some View {
        AdView()
    }
}
