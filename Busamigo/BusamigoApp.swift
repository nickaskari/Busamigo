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
    @StateObject private var homeButtonManager = HomeButtonManager()
    @StateObject private var profileButtonManager = ProfileButtonManager()
    @StateObject private var feed = FeedManager()
    @StateObject private var locationManager = LocationManager()
    @StateObject private var userManager = UserManager()
    @StateObject private var tabvm = TabViewModel()
    @StateObject private var network = Network()
    @StateObject private var popUpManager = PopUpManager()
    @StateObject private var dataController = DataController()
    
    @AppStorage("setup") private var setup = false
    @State private var showLaunchView = true
    
    init() {
        UINavigationBar.appearance().tintColor = .systemPink
        UITextView.appearance().tintColor = .systemPink
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if setup {
                    BusamigoView(feed, locationManager)
                        .environmentObject(homeButtonManager)
                        .environmentObject(profileButtonManager)
                        .environmentObject(userManager)
                        .environmentObject(feed)
                        .environmentObject(tabvm)
                        .environmentObject(network)
                        .environmentObject(popUpManager)
                        .environmentObject(locationManager)
                        .environment(\.managedObjectContext, dataController.container.viewContext)
                } else {
                    WelcomeView()
                        .environmentObject(homeButtonManager)
                        .environmentObject(profileButtonManager)
                        .environmentObject(userManager)
                        .environmentObject(feed)
                        .environmentObject(tabvm)
                        .environmentObject(network)
                        .environmentObject(popUpManager)
                        .environmentObject(locationManager)
                        .environment(\.managedObjectContext, dataController.container.viewContext)
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
            }
        }
    }
}
