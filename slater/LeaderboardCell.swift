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
        cv.backgroundColor = ColorConstants.appBackgroundColor
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "leaderboardId"
    let headerId = "headerId"
    
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
        
        addSubview(leaderboardCollection)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: leaderboardCollection)
        addConstraintsWithFormat(format: "V:|[v0]|", views: leaderboardCollection)

        
        leaderboardCollection.register(LeaderboardCellItem.self, forCellWithReuseIdentifier: cellId)
        leaderboardCollection.register(CustomHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LeaderboardCellItem
        
        cell.user = users?[indexPath.item]
        cell.userLabel.text = "\(indexPath.item+1). " + cell.userLabel.text!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CustomHeader
        
        return header
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: leaderboardCollection.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.width, height: 40)
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

class CustomHeader: UICollectionReusableView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Weekly Leaderboard"
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica Nueue", size: 24)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerLabel)
        
        addConstraintsWithFormat(format: "H:|-5-[v0]-|", views: headerLabel)
        addConstraintsWithFormat(format: "V:|-2-[v0]-2-|", views: headerLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
