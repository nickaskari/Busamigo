//
//  KarismaCalculator.swift
//  Busamigo
//
//  Created by Nick Askari on 22/06/2022.
//

import Foundation

func calculateKarisma(posts: Int, votes: Int) -> Double {
    let posts = Double(posts)
    let votes = Double(votes)
    let x = posts * 0.2 + votes
    
    if x >= 100 {
        return 100
    } else {
        return x.truncatingRemainder(dividingBy: 100)
    }
}




