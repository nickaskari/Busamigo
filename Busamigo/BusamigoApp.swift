//
//  BusamigoApp.swift
//  Busamigo
//
//  Created by Nick Askari on 09/02/2022.
//

import SwiftUI

@main
struct BusamigoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var observationManager = ObservationManager()
    
    var body: some Scene {
        WindowGroup {
            BusamigoView()
        }
    }
}
