//
//  FeedCell.swift
//  slater
//
//  Created by Philip House on 1/31/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: HomeControllerDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = ColorConstants.appBackgroundColor
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var activePoll = true {
        didSet {
            fetchPolls()
        }
    }
    
    let cellId = "pollId"
    let sidebarColors = [UIColor(red: 181/255, green: 105/255, blue: 193/255, alpha: 1),
                         UIColor(red: 87/266, green: 165/255, blue: 63/255, alpha: 1),
                         UIColor(red: 246/255, green: 171/255, blue: 26/255, alpha: 1),
                         UIColor(red: 234/255, green: 85/255, blue: 78/255, alpha: 1)]
    
    var polls: [Poll]?
    
    func fetchPolls() {
        ApiService.sharedInstance.fetchPolls(active: activePoll, completion: { (polls: [Poll]) in
            self.polls = polls
            self.collectionView.reloadData()
        })
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
        cell.sidebarView.backgroundColor = sidebarColors[indexPath.item % sidebarColors.count]
        cell.delegate = self.delegate
        
        if !activePoll {
            cell.isActivePoll = false
            cell.timeLabel.text = "closed"
            cell.holderView.backgroundColor = UIColor.lightGray
        }
        return cell
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
