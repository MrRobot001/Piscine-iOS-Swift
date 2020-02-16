//
//  APIController.swift
//  Day04
//
//  Created by Bogdan DEOMIN on 2/8/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import Foundation

class APIController {
    weak var delegate: APITwitterDelegate?
    let token: String
    var tweets: [Tweet] = []
    
    init(delegate: APITwitterDelegate?, token: String) {
        self.delegate = delegate
        self.token = token
    }
    
    func getTweets(search: String) {
        if let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json?q=" + search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "&result_type=recent&count=100&locale=en") {
            var request = URLRequest(url: url);
            request.httpMethod = "GET";
            request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization");
            let group = DispatchGroup();
            let task = URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                if let err = error {
                    print(err);
                } else if let d = data {
                    do {
                        if let dic = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] {
                            if (dic["errors"] as? [Any] != nil) {
                                DispatchQueue.main.async {
                                    self.delegate?.handleError(error: NSError(domain: "An error has occurred while loading tweets", code: 0));
                                }
                            } else {
                                if let statuses = dic["statuses"] as? [Any] {
                                    if (statuses.count > 0) {
                                        for i in 0..<statuses.count {
                                            if let tweet = statuses[i] as? [String: Any] {
                                                if let user = tweet["user"] as? [String: Any] {
                                                    let format = DateFormatter()
                                                    format.dateFormat = "EEE MMM dd HH:mm:ss x yyyy"
                                                    let date = format.date(from: tweet["created_at"] as! String)
                                                    format.dateFormat = "MM/dd/yy HH:mm"
                                                    let str = format.string(from: date!)
                                                    let tweetStruct = Tweet(name: user["name"] as! String, date: str, text: tweet["text"] as! String);
                                                    self.tweets.append(tweetStruct);
                                                }
                                            }
                                        }
                                    }
                                }
                              }
                        }
                    } catch {
                        print(error.localizedDescription);
                    }
                }
                group.leave();
            }
            group.enter();
            task.resume();
            group.wait();
            DispatchQueue.main.async {
                self.delegate?.processTweets(tweets: self.tweets);
            }
        }
    }
}
