//
//  PollView.swift
//  slater
//
//  Created by Philip House on 2/14/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class PollView: UIView {
    
    weak var delegate: LoginControllerDelegate?
    
    var poll: Poll? {
        didSet {
            answerCollectionView.answers = poll?.answers
            questionLabel.text = poll?.title
            
            if let votes = poll?.currentVoteCount {
                votesView.text = "\(votes) votes"
            }
            
        }
    }
    
    lazy var answerCollectionView: AnswerCollectionView = {
        let cv = AnswerCollectionView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let titleView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    let timeView : UILabel = {
        let text = UILabel()
        text.backgroundColor = UIColor.white
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "5 hours left"
        text.textColor = UIColor.darkGray
        return text
    }()
    
    let votesView : UILabel = {
        let text = UILabel()
        text.backgroundColor = UIColor.white
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = NSTextAlignment.right
        text.textColor = UIColor.darkGray
        text.text = "430 votes"
        return text
    }()
    
    let questionView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sidebar : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let questionLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Will the Cleveland Cavaliers and Golden State Warriors make it to the NBA Finals?"
        label.numberOfLines = 3
        label.font = UIFont(name: "HelveticaNeue", size: 22)
        return label
    }()
    
    let answerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let cellId = "cellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupTitleView()
        setupQuestionView()
        setupAnswerView()
    }
    
    func setupViews() {
        addSubview(titleView)
        addSubview(answerView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: titleView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: answerView)
        
        addConstraintsWithFormat(format: "V:|-5-[v0(150)]-10-[v1]|", views: titleView, answerView)
    }
    
    func setupTitleView() {
        titleView.addSubview(questionView)
        titleView.addSubview(timeView)
        titleView.addSubview(votesView)
        
        addConstraintsWithFormat(format: "V:|[v0(100)]-5-[v1]|", views: questionView, votesView)
        addConstraintsWithFormat(format: "V:|[v0(100)]-5-[v1]|", views: questionView, timeView)
        
        addConstraintsWithFormat(format: "H:|-5-[v0]|", views: questionView)
        addConstraintsWithFormat(format: "H:|-5-[v0(100)]", views: timeView)
        addConstraintsWithFormat(format: "H:[v0(100)]-5-|", views: votesView)
    }
    
    func setupQuestionView() {
        questionView.addSubview(sidebar)
        questionView.addSubview(questionLabel)
        
        addConstraintsWithFormat(format: "H:|[v0(5)]-12-[v1]|", views: sidebar, questionLabel)
        addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: sidebar)
        addConstraintsWithFormat(format: "V:|[v0]|", views: questionLabel)
    }
    
    func setupAnswerView() {
        answerView.addSubview(answerCollectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: answerCollectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: answerCollectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
