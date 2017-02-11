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
    
    let userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.blue
        label.text = "phouse512"
        return label
    }()
    
    // coin subimage
    let coinView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let coinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "coin")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.green
        return imageView
    }()
    
    let coinLabel: UILabel = {
        let label = UILabel()
        label.text = "341"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.blue
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupCoinView()
        backgroundColor = UIColor.red
    }
    
    func setupCoinView() {
        coinView.addSubview(coinImage)
        coinView.addSubview(coinLabel)
        
        addConstraintsWithFormat(format: "H:|-4-[v0(40)]-4-[v1]-4-|", views: coinImage, coinLabel)
        addConstraintsWithFormat(format: "V:|-4-[v0]-4-|", views: coinImage)
        addConstraintsWithFormat(format: "V:|-4-[v0]-4-|", views: coinLabel)
    }
    
    func setupViews() {
        print("boom")
        addSubview(userLabel)
        addSubview(coinView)
        
        addConstraintsWithFormat(format: "H:|-5-[v0(400)]", views: userLabel)
        addConstraintsWithFormat(format: "H:[v0(100)]-5-|", views: coinView)
        addConstraintsWithFormat(format: "V:|-2-[v0]-2-|", views: coinView)
        addConstraintsWithFormat(format: "V:|-2-[v0]-2-|", views: userLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
