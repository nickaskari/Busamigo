//
//  BusamigoApp.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI
import Firebase

@main
struct BusamigoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var scrollManager = ScrollManager()
    @StateObject private var feed = AtbFeed()
    @StateObject private var locationManager = LocationManager()
    @StateObject private var userManager = UserManager()
    @StateObject private var tabvm = TabViewModel()
    @StateObject private var network = Network()
    @StateObject private var popUpManager = PopUpManager()
    
    @AppStorage("setup") private var setup = false
    @State private var showLaunchView = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if setup {
                    BusamigoView(feed, locationManager)
                        .environmentObject(scrollManager)
                        .environmentObject(userManager)
                        .environmentObject(feed)
                        .environmentObject(tabvm)
                        .environmentObject(network)
                        .environmentObject(popUpManager)
                        .environmentObject(locationManager)
                } else {
                    WelcomeView()
                        .environmentObject(scrollManager)
                        .environmentObject(userManager)
                        .environmentObject(feed)
                        .environmentObject(tabvm)
                        .environmentObject(network)
                        .environmentObject(popUpManager)
                        .environmentObject(locationManager)
                }
                
                if showLaunchView {
                    LaunchView(showLaunchView: $showLaunchView)
                        .environmentObject(feed)
                        .environmentObject(userManager)
                }
            }
            .preferredColorScheme(.light)
            .onAppear {
                locationManager.checkIfLocationServicesIsEnabled()
                portraitOrientationLock()
                feed.listenForUpdates()
            }
        }
    }
}
