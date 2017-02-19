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
    
    let baseUrl = "https://xvv348wbr5.execute-api.us-east-1.amazonaws.com/prod/"
    let apiKey = "PT0e0Rt3Jp46n6XwN466t8Huqs6vGNrv30OYHWT1"
    
    func fetchPolls(completion: @escaping ([Poll]) -> ()) {
        let url = URL(string: baseUrl + "polls")
        var request = URLRequest(url: url!)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                var polls = [Poll]() // need to instantiate this as a new array since it's by default optional
                //print(json)
                
                for dictionary in json as! [[String: AnyObject]] {
                    let poll = Poll()
                    
                    for answers_dict in dictionary["answers"] as! [[String: AnyObject]] {
                        let answer = Answer()
                        answer.id = answers_dict["id"] as! Int?
                        answer.text = answers_dict["text"] as! String?
                        
                        poll.answers.append(answer)
                    }
                    
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
    
    func fetchLeaders(completion: @escaping ([User]) -> ()) {
        let url = URL(string: baseUrl + "leaderboard")
        var request = URLRequest(url: url!)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                print(json)
                
                var users = [User]()
                for dictionary in json as! [[String: AnyObject]] {
                    let user = User()
                    user.balance = dictionary["buy_in"] as! Int?
                    user.username = dictionary["username"] as! String?
                    users.append(user)
                }
                
                DispatchQueue.main.async {
                    completion(users)
                }
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }
}
