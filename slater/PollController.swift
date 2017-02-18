//
//  PollController.swift
//  slater
//
//  Created by Philip House on 2/14/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit


class PollController: UIViewController {
    
    var poll: Poll?
    
    lazy var pollView: PollView = {
        let view = PollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorConstants.appBackgroundColor
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupCollectionView()
        setupPollView()
    }
    
    private func setupPollView() {
        view.addSubview(pollView)
        //view.addSubview(answerCollectionView!)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: pollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: pollView)
    }
    
//    func setupCollectionView() {
//        
//        let flowLayout = UICollectionViewFlowLayout()
//        
//        answerCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
//        
//        answerCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
//        answerCollectionView?.delegate = self
//        answerCollectionView?.dataSource = self
//        answerCollectionView?.backgroundColor = UIColor.orange
//        answerCollectionView?.translatesAutoresizingMaskIntoConstraints = false
//        
//        //pollView.answerView.addSubview(answerCollectionView!)
//    }
    
    init(poll: Poll?) {
        self.poll = poll
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//        cell.backgroundColor = UIColor.brown
//        return cell
//    }
    
}
