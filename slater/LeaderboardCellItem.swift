//
//  LeaderBoardCellItem.swift
//  slater
//
//  Created by Philip House on 2/9/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class LeaderboardCellItem: UICollectionViewCell {
    
    var user: User? {
        didSet {
            userLabel.text = user?.username
            
            if let balance = user?.balance {
                coinLabel.text = "\(balance)"
            }
        }
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    let sidebarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.white
        label.text = "phouse512"
        return label
    }()
    
    // coin subimage
    let coinView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let coinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "coin")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    let coinLabel: UILabel = {
        let label = UILabel()
        label.text = "341"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupCoinView()
        backgroundColor = ColorConstants.appBackgroundColor
    }
    
    func setupCoinView() {
        coinView.addSubview(coinImage)
        coinView.addSubview(coinLabel)
        
        addConstraintsWithFormat(format: "H:[v0(15)]-4-[v1]-|", views: coinImage, coinLabel)
        addConstraintsWithFormat(format: "V:|-4-[v0]-4-|", views: coinImage)
        addConstraintsWithFormat(format: "V:|-4-[v0]-4-|", views: coinLabel)
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubview(userLabel)
        containerView.addSubview(coinView)
        containerView.addSubview(sidebarView)

//        addSubview(userLabel)
//        addSubview(coinView)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: containerView)
        addConstraintsWithFormat(format: "V:|-2-[v0]-2-|", views: containerView)
        
        addConstraintsWithFormat(format: "H:|[v0(4)]-5-[v1]", views: sidebarView, userLabel)
        addConstraintsWithFormat(format: "H:[v0(100)]-5-|", views: coinView)
        addConstraintsWithFormat(format: "V:|-2-[v0]-2-|", views: coinView)
        addConstraintsWithFormat(format: "V:|-2-[v0]-2-|", views: userLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: sidebarView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
