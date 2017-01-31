//
//  ApiService.swift
//  slater
//
//  Created by Philip House on 1/30/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func fetchPolls(completion: @escaping ([Poll]) -> ()) {
        let url = URL(string: "http://localhost:8080/")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                var polls = [Poll]() // need to instantiate this as a new array since it's by default optional
                
                for dictionary in json as! [[String: AnyObject]] {
                    let poll = Poll()
                    poll.buyIn = dictionary["buy_in"] as! Int?
                    poll.currentVoteCount = dictionary["current_votes"] as! Int?
                    poll.title = dictionary["question"] as! String?
                    polls.append(poll)
                }
                
                DispatchQueue.main.async {
                    completion(polls)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            }.resume()
    }
}
