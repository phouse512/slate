//
//  Poll.swift
//  slater
//
//  Created by Philip House on 1/30/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class Poll: NSObject {
    
    var title: String?
    var buyIn: Int?
    var currentVoteCount: Int?
    var closeTime: NSDate?
    var answers: [Answer] = []
}

class Answer: NSObject {
    
    var id: Int?
    var text: String?
}
