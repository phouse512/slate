//
//  PollView.swift
//  slater
//
//  Created by Philip House on 2/14/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class PollView: UIView {
    
    weak var delegate: LoginControllerDelegate?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
