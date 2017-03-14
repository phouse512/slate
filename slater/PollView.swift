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
            answerCollectionView.pollId = poll?.id
            print(answerCollectionView.pollId ?? 0)
            questionLabel.text = poll?.title
            
            if let votes = poll?.currentVoteCount {
                votesView.text = "\(votes) votes"
            }
            
            if let date = poll?.closeTime {
                let dateComponentsFormatter = DateComponentsFormatter()
                dateComponentsFormatter.allowedUnits = [.year,.month,.weekOfYear,.day,.hour,.minute,.second]
                dateComponentsFormatter.maximumUnitCount = 1
                dateComponentsFormatter.unitsStyle = .full
                if let timeNow = dateComponentsFormatter.string(from: Date(), to: date) {
                    timeView.text = "\(timeNow) left"
                }
            }
            
            if let buyIn = poll?.buyIn {
                coinView.coinLabel.text = "\(buyIn)"
                footerView.coin = buyIn
            }
            
            if let voted = poll?.voted {
                if voted {
                    voteButton.setTitle("Update Prediction", for: .normal)
                }
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
    
    let coinView : CoinView = {
        let view = CoinView()
        view.coinLabel.textColor = UIColor.darkGray
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
    
    lazy var voteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = ColorConstants.betButtonColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Make Prediction", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleBet), for: .touchUpInside)
        return button
    }()
    
    let footerView : FooterView = {
        let view = FooterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        return view
    }()
    
    func handleBet() {
        voteButton.isEnabled = false
        voteButton.backgroundColor = UIColor.gray
        if self.answerCollectionView.currentlyChosen < 0 {
            print("nothing chosen")
            return
        }
        
        let answerId = self.answerCollectionView.answers?[self.answerCollectionView.currentlyChosen].id
        if answerId == nil {
            print("answer id is nil, that's bad")
            return
        }
        
        ApiService.sharedInstance.makeBet(pollId: (self.poll?.id)!, answerId: answerId!, completion: { (result: Bool) in
            print(result)
            self.voteButton.isEnabled = true
            self.voteButton.backgroundColor = ColorConstants.betButtonColor
        })
    }
    
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
        addSubview(voteButton)
//        addSubview(footerView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: titleView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: answerView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: voteButton)
//        addConstraintsWithFormat(format: "H:|[v0]|", views: footerView)
        
        addConstraintsWithFormat(format: "V:|-5-[v0(150)]-10-[v1]|", views: titleView, answerView)
        addConstraintsWithFormat(format: "V:[v0(60)]-10-|", views: voteButton)
    }
    
    func setupTitleView() {
        titleView.addSubview(questionView)
        titleView.addSubview(timeView)
        titleView.addSubview(votesView)
        titleView.addSubview(coinView)
        
        
        addConstraintsWithFormat(format: "V:|[v0(100)]-5-[v1]|", views: questionView, votesView)
        addConstraintsWithFormat(format: "V:|[v0(100)]-5-[v1]|", views: questionView, timeView)
        addConstraintsWithFormat(format: "V:|[v0(100)]-5-[v1]|", views: questionView, coinView)
        
        addConstraintsWithFormat(format: "H:|-5-[v0]|", views: questionView)
//        addConstraintsWithFormat(format: "H:|-5-[v0(100)]", views: timeView)
//        addConstraintsWithFormat(format: "H:[v0(100)]-5-|", views: votesView)
        
        addConstraintsWithFormat(format: "H:|-5-[v0(==v1)]-8-[v1(==v0)]-8-[v2(==v0)]-5-|", views: coinView, timeView, votesView)
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
