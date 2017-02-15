//
//  MainNavigationController.swift
//  slater
//
//  Created by Philip House on 2/1/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if isLoggedIn() {
            let layout = UICollectionViewFlowLayout()
            let homeController = HomeController(collectionViewLayout: layout)
            
            viewControllers = [homeController]
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return true
    }
    
    func showLoginController() {
        let layout = UICollectionViewFlowLayout()
        let loginController = LoginController(collectionViewLayout: layout)
        present(loginController, animated: true, completion: {
            // perhaps
        })
    }
}
