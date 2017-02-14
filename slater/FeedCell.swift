//
//  FeedCell.swift
//  slater
//
//  Created by Philip House on 1/31/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(red: 83/255, green: 90/255, blue: 116/255, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "pollId"
    
    var polls: [Poll]?
    
    func fetchPolls() {
        ApiService.sharedInstance.fetchPolls { (polls: [Poll]) in
            self.polls = polls
            self.collectionView.reloadData()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        fetchPolls()
        
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(PollCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return polls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PollCell
        cell.poll = polls?[indexPath.item]
        return cell
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
