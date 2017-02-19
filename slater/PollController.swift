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
        setupPollView()
        print(poll ?? "not here")
        pollView.poll = poll
        
    }
    
    private func setupPollView() {
        view.addSubview(pollView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: pollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: pollView)
    }

    
    init(poll: Poll?) {
        self.poll = poll
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
