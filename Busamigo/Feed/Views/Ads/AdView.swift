//
//  AdView.swift
//  Busamigo
//
//  Created by Nick Askari on 14/07/2022.
//

import SwiftUI
import GoogleMobileAds

struct AdView: View {
    let adFormat: AdFormat
    @State private var adStatus: AdStatus = .loading
    
    var body: some View {
        
        ZStack {
            if adStatus == .loading {
                ActivityIndicator(color: .pink)
            }
             
            if adStatus != .failure {
                VStack(alignment: .leading, spacing: 5) {
                    if adStatus == .success {
                        Text("Reklame")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    
                    BannerViewController(adSize: adFormat.adSize, adStatus: $adStatus)
                        .frame(width: adFormat.size.width, height: adFormat.size.height)
                }
            }
        }
        .padding()
    }
}













struct AdView_Previews: PreviewProvider {
    static var previews: some View {
        AdView(adFormat: .mediumRectangle)
    }
}
