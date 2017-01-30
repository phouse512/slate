//
//  ViewController.swift
//  slater
//
//  Created by Philip House on 1/25/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(PollCell.self, forCellWithReuseIdentifier: "cellId")
    }
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        
        return cell
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

 class PollCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCoinView()
        setupViews()
    }
    
    let questionView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let coinView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let voteView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Coin Stuff
    let coinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "coin")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.blue
        return imageView
    }()
    
    let coinLabel: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.green
        return label
    }()
    
    func setupCoinView() {
        coinView.addSubview(coinImage)
        coinView.addSubview(coinLabel)
        
        var coinConstraints = [NSLayoutConstraint]()
        
        let heightConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]-8-|", options: [], metrics: nil, views: ["v0": coinImage])
        coinConstraints += heightConstraint
        
        let heightConstraint2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]-8-|", options: [], metrics: nil, views: ["v0": coinLabel])
        coinConstraints += heightConstraint2
        
        let horizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(==v1)]-4-[v1(==v0)]-8-|", options: [], metrics: nil, views: ["v0": coinImage, "v1": coinLabel])
        coinConstraints += horizontalConstraint
        
        NSLayoutConstraint.activate(coinConstraints)
        
    }
    
    func setupViews() {
        // do stuff
        addSubview(questionView)
        addSubview(separatorView)
        addSubview(coinView)
        addSubview(timeView)
        addSubview(voteView)
        
        
        
        var allConstraints = [NSLayoutConstraint]()
        
        let heightConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: [], metrics: nil, views: ["v0": questionView])
        allConstraints += heightConstraint
        
        // coin horizontal constraint
        let coinHeightConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0(==v1)]-8-[v1(==v0)]-8-[v2(==v0)]-16-|", options: [], metrics: nil, views: ["v0": coinView, "v1": timeView, "v2": voteView])
        allConstraints += coinHeightConstraint
        
        let verticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-8-[v2(40)]-16-[v1(1)]|", options: [], metrics: nil, views: ["v0": questionView, "v1": separatorView, "v2": coinView])
        allConstraints += verticalConstraint
        
        let verticalConstraint2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-8-[v2(40)]-16-[v1(1)]|", options: [], metrics: nil, views: ["v0": questionView, "v1": separatorView, "v2": timeView])
        allConstraints += verticalConstraint2
        
        let verticalConstraint3 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-8-[v2(40)]-16-[v1(1)]|", options: [], metrics: nil, views: ["v0": questionView, "v1": separatorView, "v2": voteView])
        allConstraints += verticalConstraint3
        
        let separatorHeightConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: [], metrics: nil, views: ["v0": separatorView])
        allConstraints += separatorHeightConstraint
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
