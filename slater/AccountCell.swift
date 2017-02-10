//
//  AccountCell.swift
//  slater
//
//  Created by Philip House on 2/9/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class AccountCell: BaseCell {
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "phil_passport")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = UIColor.red
        return view
    }()
    
    override func setupViews() {
        addSubview(profileImageView)
        
        var allConstraints = [NSLayoutConstraint]()
        
        let heightConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: [], metrics: nil, views: ["v0": profileImageView])
        allConstraints += heightConstraint
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    
}
