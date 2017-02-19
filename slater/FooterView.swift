//
//  FooterView.swift
//  slater
//
//  Created by Philip House on 2/19/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    let leftView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorConstants.colorArray[0]
        return view
    }()
    
    let middleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorConstants.colorArray[1]
        return view
    }()
    
    let rightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorConstants.colorArray[2]
        return view
    }()
    
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.green
        label.text = "Balance"
        label.font = UIFont(name: "HelveticaNeue", size: 12.0)
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupRightView()
    }
    
    func setupViews() {
        addSubview(leftView)
        addSubview(middleView)
        addSubview(rightView)
        
        addConstraintsWithFormat(format: "H:|[v0(==v1)][v1(==v0)][v2(==v0)]|", views: leftView, middleView, rightView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: leftView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: middleView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: rightView)
    }
    
    func setupRightView() {
        rightView.addSubview(balanceLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: balanceLabel)
        addConstraintsWithFormat(format: "V:|-5-[v0(15)]", views: balanceLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
