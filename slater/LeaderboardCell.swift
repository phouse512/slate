//
//  LeaderboardCell.swift
//  slater
//
//  Created by Philip House on 2/9/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class LeaderboardCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var leaderboardCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.green
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "leaderboardId"
    
    var users: [User]?
    
    func fetchUsers() {
        ApiService.sharedInstance.fetchLeaders { (users: [User]) in
            
            self.users = users
            self.leaderboardCollection.reloadData()
        }
    }
    
    
    override func setupViews() {
        super.setupViews()
        fetchUsers()
        
        print("bam")
        addSubview(leaderboardCollection)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: leaderboardCollection)
        addConstraintsWithFormat(format: "V:|[v0]|", views: leaderboardCollection)

        
        leaderboardCollection.register(LeaderboardCellItem.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LeaderboardCellItem
        
        cell.user = users?[indexPath.item]
        return cell
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: leaderboardCollection.frame.width, height: 75)
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
