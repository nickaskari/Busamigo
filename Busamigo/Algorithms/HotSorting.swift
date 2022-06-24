//
//  HotSorting.swift
//  Busamigo
//
//  Created by Nick Askari on 13/04/2022.
//

import Foundation
import SwiftUI
    
func epoch_seconds(_ date: Date) -> Double {
    return date.timeIntervalSince1970
}

func hot(_ score: Int, _ date: Date) -> Double {
    let s = score
    let order = log10(max(Double(abs(s)), 1.0))
    var sign: Double
    
    if s > 0 {
        sign = 1
    } else if s < 0 {
        sign = -1
    } else {
        sign = 0
    }
    let seconds: Double = epoch_seconds(date) - 1134028003
    
    let result: Double = (sign * order) + (seconds / 45000)
    let deci: Double = pow(10, 7)
    
    return Double(round(deci * result) / deci)
}




