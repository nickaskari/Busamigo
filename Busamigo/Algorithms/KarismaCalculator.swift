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
    let x = posts * 0.1 + votes * 0.5
    
    if x >= 50 {
        return 100
    } else if x <= -50 {
        return 0
    }
    else {
        if x >= 0 {
            return 50 + x.truncatingRemainder(dividingBy: 50)
        }
        else {
            return 50 + x.truncatingRemainder(dividingBy: 50)
        }
    }
}




