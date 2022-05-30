//
//  User.swift
//  Busamigo
//
//  Created by Nick Askari on 13/02/2022.
//

import Foundation
import MapKit
import SwiftUI

//change with firbase. Use stored id
struct User: Identifiable {
    
    let id: UUID
    private var haveVoted: Array<FeedItem>
    private (set) var votes: Int
    private (set) var postes: Int
    
    init(id: UUID) {
        self.id = id
        self.haveVoted = []
        self.votes = 0
        self.postes = 0
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
    
    mutating func post() {
        self.postes += 1
    }
    
    func computeKarisma() -> Double {
        return Double((votes/200) * 100)
    }
    
    //Implement refreshing??
}

func createNewUser() {
    @AppStorage("userID") var userID: UUID?
    
    //check uuid from firebase
    userID = UUID()
}

func getUser() -> UUID? {
    @AppStorage("userID") var userID: UUID?
    return userID
}

