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
    func createUser(username: String, password: String)
    func moveToLogin()
}

protocol LogoutDelegate: class {
    func finishLoggingOut()
}

class LoginController: UICollectionViewController, UICollectionViewDelegateFlowLayout, LoginControllerDelegate {
    
    let cellId = "cellId"
    let loginCellId = "loginCellId"
    let signupCellId = "signupCellId"
    
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
        collectionView?.register(SignupCell.self, forCellWithReuseIdentifier: signupCellId)
        
        // this makes pages snap, so you can't get stuck in between cells
        collectionView?.isPagingEnabled = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 2 {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
            loginCell.delegate = self
            return loginCell
        } else if indexPath.item == 1 {
            let signupCell = collectionView.dequeueReusableCell(withReuseIdentifier: signupCellId, for: indexPath) as! SignupCell
            signupCell.delegate = self
            return signupCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        let colors: [UIColor] = [.gray, .orange, .purple]
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func moveToLogin() {
        let indexPath = NSIndexPath(item: 2, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }
    
    func finishLoggingIn(username: String, password: String) {
        
        ApiService.sharedInstance.loginRequest(username: username, password: password, completion: { (result: AuthResponse) in
            print("request done")
            
            if result.valid {
                // successful login
                let rootViewController = UIApplication.shared.keyWindow?.rootViewController
                guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
                
                UserDefaults.standard.set(result.authToken!, forKey: "session")
                
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
    
    func createUser(username: String, password: String) {
        
        ApiService.sharedInstance.createUser(username: username, password: password, completion: { (result: Bool) in
            print("create user request done")
            
            if result {
                
                print("made it!")
                // successful
                let alert = UIAlertController(title: "Alert", message: "User created! Swipe right to login!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yay!", style: .default, handler: nil))
                self.present(alert, animated: true, completion: { ()
                    let indexPath = NSIndexPath(item: 2, section: 0)
                    self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
                })
                
            } else {
                let alert = UIAlertController(title: "Alert", message: "Failz, try again..", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
}
