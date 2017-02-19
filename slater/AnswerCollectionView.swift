//
//  AnswerCollectionView.swift
//  slater
//
//  Created by Philip House on 2/18/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class AnswerCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsetsMake(15, 10, 0, 10)

        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = ColorConstants.appBackgroundColor
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var answers: [Answer]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    let cellId = "cellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(AnswerCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AnswerCollectionViewCell
        cell.icon.layer.borderColor = ColorConstants.colorArray[indexPath.item % ColorConstants.colorArray.count].cgColor
        cell.answer = answers?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = CGFloat(10)
        let collectionViewSize = collectionView.frame.size.width - padding - 20
        return CGSize(width: collectionViewSize/2, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
