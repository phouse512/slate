//
//  CoinView.swift
//  slater
//
//  Created by Philip House on 2/18/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class CoinView: UIView {
    
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
        label.text = "30"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    func setupView() {
        addSubview(coinImage)
        addSubview(coinLabel)
        
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: coinImage)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: coinLabel)
        addConstraintsWithFormat(format: "H:|[v0(15)]-4-[v1]|", views: coinImage, coinLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

