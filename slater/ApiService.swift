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
    
    func fetchPolls(active: Bool, completion: @escaping ([Poll]) -> ()) {
        var url: URL
        if active {
            url = URL(string: baseUrl + "polls/")!
        } else {
            url = URL(string: baseUrl + "polls_old/")!
        }
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue((UserDefaults.standard.object(forKey: "session") as! String), forHTTPHeaderField: "auth")
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                if httpStatus.statusCode >= 300 {
                    print("not working")
                    print(data ?? "test")
                    return
                }
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                print(json)
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
                    
                    poll.id = dictionary["id"] as! Int?
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
    
    func fetchPollBet(pollId: Int, completion: @escaping(Int) -> ()) {
        let url = URL(string: baseUrl + "polls/\(pollId)/bet/")
        var request = URLRequest(url: url!)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue((UserDefaults.standard.object(forKey: "session") as! String), forHTTPHeaderField: "auth")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                if httpStatus.statusCode >= 300 {
                    print("fetch poll bet not working")
                    return
                }
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                let parsedData = json as! [String:Any]
                
                DispatchQueue.main.async {
                    completion(parsedData["answer_id"] as! Int)
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
        request.setValue((UserDefaults.standard.object(forKey: "session") as! String), forHTTPHeaderField: "auth")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                if httpStatus.statusCode >= 300 {
                    print("fetch leaderboard not working")
                    return
                }
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                // print(json)
                
                var users = [User]()
                for dictionary in json as! [[String: AnyObject]] {
                    let user = User()
                    user.balance = dictionary["balance"] as! Int?
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
    
    func fetchUser(completion: @escaping(User) -> ()) {
        let url = URL(string: baseUrl + "user")
        var request = URLRequest(url: url!)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue((UserDefaults.standard.object(forKey: "session") as! String), forHTTPHeaderField: "auth")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                if httpStatus.statusCode >= 300 {
                    print("fetch user not working")
                    return
                }
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                let parsedData = json as! [String:Any]
                // print(json)
                
                let newUser = User()
                newUser.balance = parsedData["balance"] as! Int?
                newUser.username = parsedData["username"] as! String?
                
                DispatchQueue.main.async {
                    completion(newUser)
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
    func fetchUserDetails(completion: @escaping(UserDetails) -> ()) {
        let url = URL(string: baseUrl + "user/detail")
        var request = URLRequest(url: url!)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue((UserDefaults.standard.object(forKey: "session") as! String), forHTTPHeaderField: "auth")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                if httpStatus.statusCode >= 300 {
                    print("fetch user details not working")
                    return
                }
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                let parsedData = json as! [String:Any]
                let userDetails = UserDetails()

                for details_dict in parsedData["closed_bets"] as! [[String: AnyObject]] {
                    
                    let title = details_dict["title"] as! String?
                    let buyIn = details_dict["buy_in"] as! Int?
                    let choice = details_dict["choice"] as! String?
                    
                    let voteDetail = VoteDetails(title: title!, buyIn: buyIn!, choice: choice!)
                    userDetails.closedBets.append(voteDetail)
                }
                
                for details_dict in parsedData["open_bets"] as! [[String: AnyObject]] {
                    
                    let title = details_dict["title"] as! String?
                    let buyIn = details_dict["buy_in"] as! Int?
                    let choice = details_dict["choice"] as! String?
                    
                    let voteDetail = VoteDetails(title: title!, buyIn: buyIn!, choice: choice!)
                    userDetails.openBets.append(voteDetail)
                }
                
                for details_dict in parsedData["winnings"] as! [[String: AnyObject]] {
                    
                    let title = details_dict["title"] as! String?
                    let winnings = details_dict["winnings"] as! Int?
                    
                    let winDetail = WinningDetails(title: title!, winnings: winnings!)
                    userDetails.winnings.append(winDetail)
                }
                DispatchQueue.main.async {
                    completion(userDetails)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
        
    }
    
    func createUser(username: String, password: String, completion: @escaping(Bool) -> ()) {
        
        let url = URL(string: baseUrl + "signup")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        var dataBlob = [String:String]()
        dataBlob["username"] = username
        dataBlob["pw"] = password
        
        do {
            let data = try JSONSerialization.data(withJSONObject: dataBlob, options: .prettyPrinted)
            request.httpBody = data
        } catch {
            print(error.localizedDescription)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error!)
                DispatchQueue.main.async {
                    completion(false)
                }
            }
            
            do {
                if let httpStatus = response as? HTTPURLResponse {
                    if httpStatus.statusCode != 200 {
                        print("received non-200 status code: \(httpStatus.statusCode)")
                        DispatchQueue.main.async {
                            completion(false)
                        }
                        return
                    }
                }
                
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                print(json)
//                
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch let jsonError{
                print(jsonError)
                
            }
        }.resume()
        
        
    }
    
    func loginRequest(username: String, password: String, completion: @escaping(AuthResponse) -> ()) {
        
        let url = URL(string: baseUrl + "login")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        var dataBlob = [String:String]()
        dataBlob["username"] = username
        dataBlob["pw"] = password
        
        print("inside login")
        let deviceToken = UserDefaults.standard.object(forKey: "deviceToken")
        print("ARGS DEVICE TOKEN BOOM \(deviceToken)")
        if let deviceToken = UserDefaults.standard.object(forKey: "deviceToken") {
            print("inside")
            print(deviceToken)
            dataBlob["device_token"] = deviceToken as! String
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: dataBlob, options: .prettyPrinted)
            //let decoded = try JSONSerialization.jsonObject(with: data, options: []) as! String
            
            request.httpBody = data
        } catch {
            print(error.localizedDescription)
            return
        }
        
        //let paramString = "username=" + username + "&pw=" + password
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            let authResponse = AuthResponse(valid: true)
            
            if error != nil {
                print(error!)
                authResponse.valid = false
                DispatchQueue.main.async {
                    completion(authResponse)
                }
            }
            
            do {
                if let httpStatus = response as? HTTPURLResponse {
                    if httpStatus.statusCode != 200 {
                        print("not working")
                        authResponse.valid = false
                        
                        DispatchQueue.main.async {
                            completion(authResponse)
                        }
                        return
                    }
                }
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                let parsedData = json as! [String:Any]
                authResponse.authToken = parsedData["auth_token"] as! String?
                print(parsedData)
                
                DispatchQueue.main.async {
                    completion(authResponse)
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
    func makeBet(pollId: Int, answerId: Int, completion: @escaping(Bool) -> ()) {
    
        let url = URL(string: baseUrl + "polls/\(pollId)/bet")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        var dataBlob = [String:String]()
        dataBlob["answer_id"] = String(answerId)
        
        do {
            let data = try JSONSerialization.data(withJSONObject: dataBlob, options: .prettyPrinted)
            request.httpBody = data
        } catch {
            print(error.localizedDescription)
            return
        }
        
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue((UserDefaults.standard.object(forKey: "session") as! String), forHTTPHeaderField: "auth")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                print(json)
                
                let result = true
                
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }
}
