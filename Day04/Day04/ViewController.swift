//
//  ViewController.swift
//  Day04
//
//  Created by Bogdan DEOMIN on 2/8/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var token: String?
    var apiController : APIController?
    var tweets: [Tweet]?
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTweets(string: "Unit Factory")
    }
    
    func searchTweets(string: String) {
        let queue = DispatchQueue.global(qos: DispatchQoS.userInitiated.qosClass);
        queue.async {
//            DispatchQueue.main.async {
//                UIApplication.shared.isNetworkActivityIndicatorVisible = true
//            }
            self.getKeysAndTokens()
            if let t = self.token {
                self.apiController = APIController(delegate: self, token: t)
                self.apiController?.getTweets(search: string)
            }
//            DispatchQueue.main.async {
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            }
        }
    }
    
    func getKeysAndTokens() {
        
        let CUSTOMER_KEY = "w0c7yEBTzIyP1J3L9LiBDLji6"
        let CUSTOMER_SECRET = "SW3auEdG0sRc8B3v9ZtwVPTAJYwdSC7dpoK08HBtq4R7kIQ8tr"
        let BEARER = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0));
            let url = URL(string: "https://api.twitter.com/oauth2/token");
            var request = URLRequest(url: url!);
            request.httpMethod = "POST";
            request.setValue("Basic " + BEARER!, forHTTPHeaderField: "Authorization");
            request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type");
            request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8);
            let group = DispatchGroup();
            let task = URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                if let err = error {
                    print(err);
                } else if let d = data {
                    do {
                        if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            if (dic["errors"] as? [Any] != nil) {
                                DispatchQueue.main.async {
                                    self.handleError(error: NSError(domain: "An error occurred while loading tweets", code: 0));
                                }
                            } else {
                                self.token = dic["access_token"] as? String;
                            }
                        }
                    } catch {
                        print(error.localizedDescription);
                    }
                }
                group.leave();
            };
            group.enter();
            task.resume();
            group.wait();
        }
}

extension ViewController: APITwitterDelegate {
    func processTweets(tweets: [Tweet]) {
        self.tweets = tweets
        for tweet in tweets {
            print(tweet)
        }
        tableView.reloadData()
    }
    
    func handleError(error: NSError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets != nil ? self.tweets!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.tweet = tweets![indexPath.row]
        cell.textLbl?.numberOfLines = 0
        return cell
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("gddh")
        if let search = textField.text {
            if (textField.text!.isEmpty == false) {
                processTweets(tweets: []);
                searchTweets(string: search)
                return (true);
            }
        }
        return (false);
    }
}
