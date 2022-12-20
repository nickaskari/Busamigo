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
  let navigationTitle: String

  var body: some View {
      HStack {
          Spacer()
          BannerView()
              .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .center)
              .scaledToFit()
          Spacer()
      }
  }
}

private struct BannerView: UIViewControllerRepresentable {
    @State private var viewWidth: CGFloat = .zero
    private let bannerView = GADBannerView(adSize: GADAdSizeMediumRectangle)
    private let adUnitID = "ca-app-pub-3940256099942544/2934735716"

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











