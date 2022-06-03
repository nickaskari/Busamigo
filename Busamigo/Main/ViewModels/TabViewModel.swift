//
//  TabViewModel.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import Foundation
import SwiftUI

class TabViewModel: ObservableObject {
    
    @Published var currentPage: Page = .feed
}

enum Page {
    case feed
    case profile
    case map
}
