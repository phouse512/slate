//
//  WelcomeCell.swift
//  slater
//
//  Created by Philip House on 3/9/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class WelcomeCell: UICollectionViewCell {
    
    weak var delegate: LoginControllerDelegate?

    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to slater!"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: label.font.fontName, size: 37)
        return label
    }()
    
    let choosePollLabel: UILabel = {
        let label = UILabel()
        label.text = "1. Pick winners and outcomes"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: label.font.fontName, size: 22)
        return label
    }()
    
    let cashOutLabel: UILabel = {
        let label = UILabel()
        label.text = "2. Win and take the pool!"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: label.font.fontName, size: 22)
        return label
    }()
    
    let coinComparisonView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    let coinView: CoinView = {
        let coinView = CoinView()
        coinView.translatesAutoresizingMaskIntoConstraints = false
        coinView.coinLabel.textColor = UIColor.white
        coinView.coinLabel.text = "850"
        coinView.coinLabel.font = UIFont(name: coinView.coinLabel.font.fontName, size: 28)
        return coinView
    }()
    
    let dollarLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "=    $1"
        label.font = UIFont(name: label.font.fontName, size: 28)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var startLabel: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        var attrs = [
            NSFontAttributeName : UIFont.systemFont(ofSize: 16.0),
            NSForegroundColorAttributeName : UIColor.white,
            NSUnderlineStyleAttributeName : 1
            ] as [String : Any]
        
        button.setAttributedTitle(NSMutableAttributedString(string: "Move right to get started!", attributes: attrs), for: UIControlState.normal)
        button.addTarget(self, action: #selector(getStarted), for: .touchUpInside)
        return button
    }()
    
    func getStarted() {
        delegate?.moveToPage(page: 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .purple
        
        setupDollarView()
        
        addSubview(welcomeLabel)
        addSubview(choosePollLabel)
        addSubview(cashOutLabel)
        addSubview(coinComparisonView)
        addSubview(startLabel)
        
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: welcomeLabel)
        addConstraintsWithFormat(format: "H:|-44-[v0]", views: choosePollLabel)
        addConstraintsWithFormat(format: "H:|-44-[v0]", views: cashOutLabel)
        addConstraintsWithFormat(format: "H:|-75-[v0]-85-|", views: coinComparisonView)
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: startLabel)
        
        addConstraintsWithFormat(format: "V:|-70-[v0]-40-[v1]-20-[v2]-30-[v3(40)]", views: welcomeLabel, choosePollLabel, cashOutLabel, coinComparisonView)
        addConstraintsWithFormat(format: "V:[v0]-30-|", views: startLabel)
    }
    
    func setupDollarView() {
        coinComparisonView.addSubview(coinView)
        coinComparisonView.addSubview(dollarLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]-5-[v1]|", views: coinView, dollarLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: coinView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: dollarLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

