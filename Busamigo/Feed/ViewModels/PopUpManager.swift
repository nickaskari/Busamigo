//
//  PopUpManager.swift
//  Busamigo
//
//  Created by Nick Askari on 27/05/2022.
//

import Foundation

class PopUpManager: ObservableObject {
    @Published var stopSearchIsActive = false
    @Published var routeSearchIsActive = false
    @Published var skipToAddIsActive = false
    @Published var addFeedItemIsActive = false

    func returnTofeed() {
        stopSearchIsActive = false
        routeSearchIsActive = false
        addFeedItemIsActive = false
        skipToAddIsActive = false
    }
}
