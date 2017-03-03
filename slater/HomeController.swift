//
//  ViewController.swift
//  slater
//
//  Created by Philip House on 1/25/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

protocol HomeControllerDelegate: class {
    func goToPollView(poll: Poll, sidebarColor: UIColor)
}

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomeControllerDelegate, LogoutDelegate {
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
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
    
    
    let cellId = "cellId"
    let accountCellId = "accountId"
    let leaderboardId = "leaderboardId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        
        
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
        
        let barButtonItem = UIBarButtonItem()
        barButtonItem.customView = navView
        navigationItem.rightBarButtonItem = barButtonItem
        
        // update balance
        fetchUser()
        
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }
    
    // this sends us to the poll
    func goToPollView(poll: Poll, sidebarColor: UIColor) {
        let pollController = PollController(poll: poll, sidebarColor: sidebarColor)
        navigationController?.pushViewController(pollController, animated: true)
    }
    
    func setupNavBarButtons() {
//        let searchImage = UIImage(named: "search2")
//        searchImage?.withRenderingMode(.alwaysOriginal)
//        let searchBarButtomItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
//        
//        let moreButton = UIBarButtonItem(image: UIImage(named: "more2")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
//        
//        
//        navigationItem.rightBarButtonItems = [moreButton, searchBarButtomItem]
    }
    
    func handleSearch() {
        scrollToMenuIndex(menuIndex: 2)
    }
    
    func finishLoggingOut() {
        print("logging out")
        UserDefaults.standard.removeObject(forKey: "session")
        navigationController?.viewDidLoad()
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
        
        setTitleForIndex(index: menuIndex)
    }
    
    private func setTitleForIndex(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    func handleMore() {
    }
    
    func setupCollectionView() {
        
        // allows for horizontal scrolling
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor(red: 83/255, green: 90/255, blue: 116/255, alpha: 1)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(AccountCell.self, forCellWithReuseIdentifier: accountCellId)
        collectionView?.register(LeaderboardCell.self, forCellWithReuseIdentifier: leaderboardId)
        
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x/4
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 3 {
            let accountCell = collectionView.dequeueReusableCell(withReuseIdentifier: accountCellId, for: indexPath) as! AccountCell
            accountCell.delegate = self
            return accountCell
        } else if indexPath.item == 1 {
            let leaderboardCell = collectionView.dequeueReusableCell(withReuseIdentifier: leaderboardId, for: indexPath) as! LeaderboardCell
            return leaderboardCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        cell.delegate = self
        
        if indexPath.item == 2 {
            print("here inside collection view")
            cell.activePoll = false
        }
        //let colors: [UIColor] = [.blue, .green, .gray, .purple]
        
        //cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    let titles = ["Open Polls", "Leaderboard", "Past Polls", "Profile"]
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
        
        setTitleForIndex(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }

    private func setupMenuBar() {
        // this toggles whether or not you can 'scroll up' the top menu bar to shorten it and hide text
        navigationController?.hidesBarsOnSwipe = false
        
        let redView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = ColorConstants.menubarColor
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
}
