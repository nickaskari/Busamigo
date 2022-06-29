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
    
    var body: some Scene {
        WindowGroup {
            BusamigoView(feed, locationManager)
                .environmentObject(scrollManager)
                .environmentObject(userManager)
                .environmentObject(feed)
                .environmentObject(tabvm)
                .environmentObject(network)
        }
    }
}
