//
//  User.swift
//  slater
//
//  Created by Philip House on 2/9/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var username: String?
    var balance: Int?
    
}

class UserDetails: NSObject {
    
    var closedBets: [VoteDetails]
    var openBets: [VoteDetails]
    var winnings: [WinningDetails]
    
    override init() {
        closedBets = []
        openBets = []
        winnings = []
    }
}

class VoteDetails: NSObject {
    
    var title: String
    var buyIn: Int
    var choice: String
    
    init(title: String, buyIn: Int, choice: String) {
        self.title = title
        self.buyIn = buyIn
        self.choice = choice
    }
    
    func to_string() -> String {
        return "You chose \(self.choice) for \(self.title)"
    }
}

class WinningDetails: NSObject {
    
    var title: String
    var winnings: Int
    
    init(title: String, winnings: Int) {
        self.title = title
        self.winnings = winnings
    }
    
    func to_string() -> String {
        if self.winnings > 0 {
            return "You made +\(self.winnings) off of \(self.title)"
        } else {
            return "You lost -\(self.winnings) on \(self.title)"
        }
    }
}
