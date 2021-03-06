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
            //self.answerMap = [Int:Int]()
            self.collectionView.reloadData()
        }
    }
    
    var pollId: Int? {
        didSet {
            print(self.pollId ?? "no id")
            self.collectionView.reloadData()
            getCurrentlySelected()
        }
    }
    
    var currentlyChosen: Int
    
    func getCurrentlySelected() {
        ApiService.sharedInstance.fetchPollBet(pollId: self.pollId!, completion: { (result: Int) in
            if let pollPosition = self.answerMap[result] {
                let selectedIndex = NSIndexPath(item: pollPosition, section: 0)
                self.collectionView.selectItem(at: selectedIndex as IndexPath, animated: true, scrollPosition: .top)
            }
        })
    }
    
    var answerMap: [Int:Int]
    
    let cellId = "cellId"
    
    override init(frame: CGRect) {
        self.answerMap = [Int:Int]()
        self.currentlyChosen = -1
        
        super.init(frame: frame)
        
        collectionView.register(AnswerCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        //getCurrentlySelected()
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
        let id = (answers?[indexPath.item].id)!
        self.answerMap[id] = indexPath.item
        //print(self.answerMap)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentlyChosen = indexPath.item
    }
}
