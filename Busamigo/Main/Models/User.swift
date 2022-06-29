//
//  User.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import Foundation
import SwiftUI

struct User: Codable, Identifiable {
    let id: String
    let posts: Int
    let votes: Int
    let deviceToken: String
}

