//
//  PopUpManager.swift
//  Busamigo
//
//  Created by Nick Askari on 27/05/2022.
//

import Foundation

class PopUpManager: ObservableObject {
    @Published var stopSearchIsActive = false

    func returnTofeed() {
        stopSearchIsActive = false
    }
}
