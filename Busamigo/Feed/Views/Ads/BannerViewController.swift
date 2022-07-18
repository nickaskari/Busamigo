//
//  BannerViewController.swift
//  Busamigo
//
//  Created by Nick Askari on 14/07/2022.
//

import SwiftUI
import GoogleMobileAds

final class BannerViewController: UIViewControllerRepresentable  {
    
    let adUnitID = "ca-app-pub-3940256099942544/2934735716" //test ID
    private let adSize: GADAdSize
    @Binding var adStatus: AdStatus
    
    init(adSize: GADAdSize, adStatus: Binding<AdStatus>) {
        self.adSize = adSize
        self._adStatus = adStatus
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(bannerViewController: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        
        let view = GADBannerView(adSize: adSize)
        view.delegate = context.coordinator
        view.adUnitID = adUnitID
        view.rootViewController = viewController
        view.load(GADRequest())
        
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: adSize.size)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    class Coordinator: NSObject, GADBannerViewDelegate {
        
        var bannerViewController: BannerViewController
        
        init(bannerViewController: BannerViewController) {
            self.bannerViewController = bannerViewController
        }
        
        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            bannerViewController.adStatus = .failure
            print("Ad failed to load")
        }
        
        func adViewDidReceiveAd(_ bannerView: GADBannerView) {
            bannerViewController.adStatus = .success
            print("Ad succeded to load")
        }
    }
}
