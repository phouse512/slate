//
//  Poll.swift
//  slater
//
//  Created by Philip House on 1/30/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class Poll: NSObject {
    
    var id: Int?
    var title: String?
    var buyIn: Int?
    var currentVoteCount: Int?
    var closeTime: Date?
    var answers: [Answer] = []
    var voted: Bool = false
}

class Answer: NSObject {
    
    var id: Int?
    var text: String?
}
