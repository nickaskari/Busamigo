//
//  GADBannerViewController.swift
//  Busamigo
//
//  Created by Nick Askari on 03/07/2022.
//

import SwiftUI
import GoogleMobileAds

struct GADBannerViewController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = GADBannerView(adSize: GADAdSizeMediumRectangle)
        let viewController = UIViewController()
        let testID = "ca-app-pub-3940256099942544/2934735716"
        //let realID =
        
        // Banner Ad
        view.adUnitID = testID
        view.rootViewController = viewController
        
        // View Controller
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: GADAdSizeMediumRectangle.size)
        
        // Load an ad
        view.load(GADRequest())
        
        return viewController
      }
      
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

