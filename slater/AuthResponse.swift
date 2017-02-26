//
//  AuthResponse.swift
//  slater
//
//  Created by Philip House on 2/26/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class AuthResponse: NSObject {
    
    var userId: Int?
    var authToken: String?
    var createdAt: NSDate?
    var expiresAt: NSDate?

}
