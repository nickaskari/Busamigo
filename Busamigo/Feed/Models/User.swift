//
//  User.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import Foundation

struct User: Identifiable {
    
    let id = UUID()
    private(set) var haveVoted: Array<FeedItem> = []
    private var votes: Int = 0
    //need better rating system
    var credibility: Double {
        return Double((votes/200) * 100)
    }
    
    mutating func canVote(item: FeedItem) -> Bool {
        if haveVoted.contains(item) {
            return false
        } else {
            haveVoted.append(item)
            return true
        }
    }
    
    mutating func recieveUpVote() {
        self.votes += 1
    }
    
    mutating func recieveDownVote() {
        self.votes -= 1
    }
    
    //Implement refreshing
}
