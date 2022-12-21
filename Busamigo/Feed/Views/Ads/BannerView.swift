//
//  BannerView.swift
//  Busamigo
//
//  Created by Nick Askari on 14/07/2022.
//

import SwiftUI
import GoogleMobileAds

// test ads: ca-app-pub-3940256099942544/2934735716
// real ads: ca-app-pub-4906057237935048/7437936815

struct BannerAdView: View {

  var body: some View {
      ZStack {
          ActivityIndicator(color: .pink)
          
          HStack {
              Spacer()
              BannerView()
                  .frame(width: 300, height: 250, alignment: .center)
              Spacer()
          }
      }
      .padding(.bottom, 5)
      .padding()
  }
}

private struct BannerView: UIViewControllerRepresentable {
    @State private var viewWidth: CGFloat = .zero
    private let bannerView = GADBannerView(adSize: GADAdSizeMediumRectangle)
    private let adUnitID = "ca-app-pub-4906057237935048/7437936815"

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: GADAdSizeMediumRectangle)

        let viewController = UIViewController()
        view.adUnitID = adUnitID
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: GADAdSizeMediumRectangle.size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

}











