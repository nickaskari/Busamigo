//
//  Status.swift
//  Busamigo
//
//  Created by Nick Askari on 22/07/2022.
//

import Foundation
import SwiftUI

enum Status {
    case genericError
    case newObservations
    case redundantVote
    case networkError
    case none
    
    var message: String {
        switch self {
        case .genericError:
            return "Ops! Det har oppstått et problem."
        case .newObservations:
            return "Nye observasjoner"
        case .redundantVote:
            return "Du har allerede stemt.."
        case .networkError:
            return "Ops! Ingen internet-tilkobling"
        case .none:
            return ""
        }
    }
    
}
