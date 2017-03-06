//
//  SignupCell.swift
//  slater
//
//  Created by Philip House on 3/5/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class SignupCell: UICollectionViewCell {
    
    weak var delegate: LoginControllerDelegate?
    
    let signupLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var loginLabel: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        var attrs = [
            NSFontAttributeName : UIFont.systemFont(ofSize: 14.0),
            NSForegroundColorAttributeName : UIColor.darkGray,
            NSUnderlineStyleAttributeName : 1
        ] as [String : Any]
        
//        label.attributedText = NSMutableAttributedString(string: "Already signed up? Sign In.", attributes: attrs)
//        label.textAlignment = NSTextAlignment.center
        button.setAttributedTitle(NSMutableAttributedString(string: "Already signed up? Sign In.", attributes: attrs), for: UIControlState.normal)
//        button.setTitle("test", for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let userTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "username.."
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "pw.."
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        textField.keyboardType = .default
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.purple
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func handleSignup() {
        print("signing up")
        delegate?.createUser(username: userTextField.text!, password: passwordTextField.text!)
    }
    
    func handleLogin() {
        print("moving to login page")
        delegate?.moveToLogin()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(userTextField)
        addSubview(passwordTextField)
        addSubview(signupButton)
        addSubview(signupLabel)
        addSubview(loginLabel)
        
        backgroundColor = .orange
        
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: userTextField)
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: passwordTextField)
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: signupButton)
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: signupLabel)
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: loginLabel)
        
        addConstraintsWithFormat(format: "V:[v0]-20-[v1(50)]-8-[v2(50)]-16-[v3(50)]-16-[v4]-80-|", views: signupLabel, userTextField, passwordTextField, signupButton, loginLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
