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
    var sidebarColor: UIColor
    
    lazy var pollView: PollView = {
        let view = PollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorConstants.appBackgroundColor
        return view
    }()
    
    var user: User? {
        didSet {
            if let balance = user?.balance {
                let subview = navigationItem.rightBarButtonItem?.customView?.subviews[0] as! CoinView
                subview.coinLabel.text = "\(balance)"
            }
        }
    }
    
    func fetchUser() {
        ApiService.sharedInstance.fetchUser(completion: { (user: User) in
            self.user = user
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // add coinView to to navbar
        let coinView = CoinView()
        coinView.coinLabel.textColor = UIColor.white
        coinView.translatesAutoresizingMaskIntoConstraints = false
        
        let navView = UIView()
        navView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(coinView)
        
        navView.addConstraintsWithFormat(format: "H:[v0]-5-|", views: coinView)
        navView.addConstraintsWithFormat(format: "V:|[v0]|", views: coinView)
        // navigationItem.titleView = navView
        
        let barButtonItem = UIBarButtonItem(customView: navView)
        navigationItem.rightBarButtonItem = barButtonItem
        
        fetchUser()
        
        pollView.poll = poll
        setupPollView()
        
    }
    
    private func setupPollView() {
        view.addSubview(pollView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: pollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: pollView)
    }

    
    init(poll: Poll?, sidebarColor: UIColor) {
        self.poll = poll
        print(poll ?? "no_poll")
        self.sidebarColor = sidebarColor
        super.init(nibName: nil, bundle: nil)
        
        pollView.sidebar.backgroundColor = sidebarColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
