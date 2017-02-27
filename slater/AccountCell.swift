//
//  AccountCell.swift
//  slater
//
//  Created by Philip House on 2/9/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class AccountCell: BaseCell {
    
    weak var delegate: LogoutDelegate?
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "phil_passport")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = UIColor.red
        return view
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    func handleLogout() {
        delegate?.finishLoggingOut()
    }
    
    override func setupViews() {
        addSubview(profileImageView)
        addSubview(logoutButton)
        
        var allConstraints = [NSLayoutConstraint]()
        
        let heightConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-50-|", options: [], metrics: nil, views: ["v0": profileImageView])
        allConstraints += heightConstraint
        
        NSLayoutConstraint.activate(allConstraints)
        
        addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: logoutButton)
        addConstraintsWithFormat(format: "V:|-5-[v0]-5-[v1(30)]-5-|", views: profileImageView, logoutButton)
    }
    
    
}
