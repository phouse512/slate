//
//  AccountCell.swift
//  slater
//
//  Created by Philip House on 2/9/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class AccountCell: BaseCell, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: LogoutDelegate?
    
    var userDetails: UserDetails?
    
    lazy var openBets: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.clear
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    lazy var closedBets: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.clear
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    lazy var winnings: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.clear
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ColorConstants.betButtonColor
        button.setTitle("Refresh", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
        return button
    }()
    
    func handleRefresh() {
        loadUserDetails()
    }
    
    func handleLogout() {
        delegate?.finishLoggingOut()
    }
    
    func loadUserDetails() {
        ApiService.sharedInstance.fetchUserDetails(completion: { (userDetails: UserDetails) in
            self.userDetails = userDetails
            self.openBets.reloadData()
            self.openBets.sizeToFit()
            self.closedBets.reloadData()
            self.closedBets.sizeToFit()
            self.winnings.reloadData()
            self.winnings.sizeToFit()
        })
    }
    
    override func setupViews() {
        addSubview(openBets)
        addSubview(closedBets)
        addSubview(winnings)
        addSubview(logoutButton)
        addSubview(refreshButton)
        
        addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: openBets)
        addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: closedBets)
        addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: winnings)
        
        addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: refreshButton)
        addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: logoutButton)
        addConstraintsWithFormat(format: "V:|-5-[v0(175)]-5-[v1(125)]-5-[v2(120)]", views: openBets, closedBets, winnings)
        addConstraintsWithFormat(format: "V:[v0(40)]-5-[v1(40)]-5-|", views: refreshButton, logoutButton)
        
        openBets.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        closedBets.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        winnings.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        
        loadUserDetails()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int?
        
        if tableView == self.closedBets {
            count = self.userDetails?.closedBets.count ?? 0
        }
        
        if tableView == self.openBets {
            count = self.userDetails?.openBets.count ?? 0
        }
        
        if tableView == self.winnings {
            count = self.userDetails?.winnings.count ?? 0
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: self.frame.width, height: 40))
        
        if tableView == self.closedBets {
            label.text = "Closed Bets"
        } else if tableView == self.openBets {
            label.text = "Open Bets"
        } else if tableView == self.winnings {
            label.text = "Recent Winnings"
        }
        
        label.backgroundColor = UIColor.clear
        view.backgroundColor = UIColor.lightGray
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        
        if tableView == self.closedBets {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            cell?.textLabel?.text = userDetails?.closedBets[indexPath.item].to_string() ?? "not loaded"
        }
        
        if tableView == self.openBets {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell?.textLabel?.text = userDetails?.openBets[indexPath.item].to_string() ?? "not loaded"
        }
        
        if tableView == self.winnings {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            cell?.textLabel?.text = userDetails?.winnings[indexPath.item].to_string() ?? "not loaded"
        }
        
        return cell!
    }
}
