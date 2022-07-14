//
//  HomeButtonManager.swift
//  Busamigo
//
//  Created by Nick Askari on 03/06/2022.
//

import Foundation

class HomeButtonManager: ObservableObject {
    @Published var scrollToTop: Bool = false
    @Published var dismiss: Bool = false
}
