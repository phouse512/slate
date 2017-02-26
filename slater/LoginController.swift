//
//  LoginController.swift
//  slater
//
//  Created by Philip House on 2/1/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

protocol LoginControllerDelegate: class {
    func finishLoggingIn(username: String, password: String)
}

class LoginController: UICollectionViewController, UICollectionViewDelegateFlowLayout, LoginControllerDelegate {
    
    let cellId = "cellId"
    let loginCellId = "loginCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        
        // allow for horizontal scrolling
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        // by default there is a small gap between top, this removes it
        automaticallyAdjustsScrollViewInsets = false
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
        
        // this makes pages snap, so you can't get stuck in between cells
        collectionView?.isPagingEnabled = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 1 {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
            loginCell.delegate = self
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        let colors: [UIColor] = [.gray, .purple]
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func finishLoggingIn(username: String, password: String) {
        
        ApiService.sharedInstance.loginRequest(username: username, password: password, completion: { (result: Bool) in
            print("request done")
            
            if result {
                // successful login
                let rootViewController = UIApplication.shared.keyWindow?.rootViewController
                guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
                
                mainNavigationController.viewControllers = [HomeController(collectionViewLayout: UICollectionViewFlowLayout())]
                self.dismiss(animated: true, completion: nil)
                // need to set auth token returned from server
//                mainNavigationController.is
            } else {
                // login failz
                let alert = UIAlertController(title: "Alert", message: "Login Failed", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
}
