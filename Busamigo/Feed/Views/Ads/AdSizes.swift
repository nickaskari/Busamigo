//
//  AdSizes.swift
//  Busamigo
//
//  Created by Nick Askari on 14/07/2022.
//

import Foundation
import GoogleMobileAds

enum AdFormat {
    
    case largeBanner
    case mediumRectangle
    case thinRectangle
    
    var adSize: GADAdSize {
        switch self {
        case .largeBanner:
            return GADAdSizeLargeBanner
        case .mediumRectangle:
            return GADAdSizeMediumRectangle
        case .thinRectangle:
            return GADAdSizeBanner
        }
    }
    
    var size: CGSize {
        adSize.size
    }
}
