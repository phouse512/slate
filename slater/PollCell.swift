//
//  PollCell.swift
//  slater
//
//  Created by Philip House on 1/30/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// this class represents the individual poll that is a part of 
//  the collectionview in feedcell

class PollCell: UICollectionViewCell {
    
    weak var delegate: HomeControllerDelegate?
    
    var poll: Poll? {
        didSet {
            questionLabel.text = poll?.title
            
            if let buyIn = poll?.buyIn {
                coinUIView.coinLabel.text = "\(buyIn)"
            }
            
            if let votes = poll?.currentVoteCount {
                voteLabel.text = "\(votes)"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupQuestionView()
        setupTimeView()
        setupVoteView()
        setupViews()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PollCell.handleTap))
        self.addGestureRecognizer(tap)
    }
    
    func handleTap() {
        delegate?.goToPollView(poll: self.poll!)
    }
    
    // sidebar view
    let sidebarView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // holder view of everything
    let holderView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    // question view
    let questionView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let questionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.white
        label.text = "Bulls or Cavaliers - 2/03/17"
        label.layoutMargins = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0)
        label.numberOfLines = 2
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // time view details
    let timeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5 hours left"
        return label
    }()
    
    // Vote View details
    let voteView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let voteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "users")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    let voteLabel: UILabel = {
        let label = UILabel()
        label.text = "12"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let coinUIView: CoinView = {
        let view = CoinView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupQuestionView() {
        questionView.addSubview(questionLabel)
        
        var questionConstraints = [NSLayoutConstraint]()
        
        
        let heightConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]-8-|", options: [], metrics: nil, views: ["v0": questionLabel])
        questionConstraints += heightConstraint
        
        let widthConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: [], metrics: nil, views: ["v0": questionLabel])
        questionConstraints += widthConstraint
        
        NSLayoutConstraint.activate(questionConstraints)
    }
    
    func setupTimeView() {
        timeView.addSubview(timeLabel)
        
        var timeConstraints = [NSLayoutConstraint]()
        
        let heightConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]-8-|", options: [], metrics: nil, views: ["v0": timeLabel])
        timeConstraints += heightConstraint
        
        let widthConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-|", options: [], metrics: nil, views: ["v0": timeLabel])
        timeConstraints += widthConstraint
        
        NSLayoutConstraint.activate(timeConstraints)
    }
    
    func setupVoteView() {
        voteView.addSubview(voteImage)
        voteView.addSubview(voteLabel)
        var voteConstraints = [NSLayoutConstraint]()
        
        let heightContraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]-8-|", options: [], metrics: nil, views: ["v0": voteImage])
        voteConstraints += heightContraint
        let heightContraint2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]-8-|", options: [], metrics: nil, views: ["v0": voteLabel])
        voteConstraints += heightContraint2
        
        let horizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(==v1)]-4-[v1(==v0)]-8-|", options: [], metrics: nil, views: ["v0": voteImage, "v1": voteLabel])
        voteConstraints += horizontalConstraint
        
        NSLayoutConstraint.activate(voteConstraints)
    }
    
    func setupViews() {

        holderView.addSubview(questionView)
        holderView.addSubview(coinUIView)
        holderView.addSubview(timeView)
        holderView.addSubview(voteView)
        holderView.addSubview(sidebarView)
        
        addSubview(holderView)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: holderView)
        addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: holderView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: sidebarView)
        
        var allConstraints = [NSLayoutConstraint]()
        let heightConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[v1(8)]-8-[v0]-4-|", options: [], metrics: nil, views: ["v1": sidebarView, "v0": questionView])
        allConstraints += heightConstraint
        
        // coin horizontal constraint
        let coinHeightConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[v3(8)]-8-[v0(==v1)]-8-[v1(==v0)]-8-[v2(==v0)]-4-|", options: [], metrics: nil, views: ["v0": coinUIView, "v1": timeView, "v2": voteView, "v3": sidebarView])
        allConstraints += coinHeightConstraint

        // this is the old separator
        let verticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[v0]-8-[v2(40)]-4-|", options: [], metrics: nil, views: ["v0": questionView, "v2": coinUIView])
        allConstraints += verticalConstraint
        
        let verticalConstraint2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[v0]-8-[v2(40)]-4-|", options: [], metrics: nil, views: ["v0": questionView, "v2": timeView])
        allConstraints += verticalConstraint2
        
        let verticalConstraint3 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[v0]-8-[v2(40)]-4-|", options: [], metrics: nil, views: ["v0": questionView, "v2": voteView])
        allConstraints += verticalConstraint3
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
