//
//  ViewController.swift
//  Rush00
//
//  Created by Bogdan DEOMIN on 2/9/20.
//  Copyright © 2020 Bogdan DEOMIN. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {
    
    private let UID = "a71616084df9d175020ad19fe8d33204d9d9c56fe13e810d45ab3f4b39a4dd16"
    private let SECRET = "1a6cd0049ada27b204244849b1561e13d23bb4eb397f19dcbdc579888c13dd57"
    private let myURL = "bdeomin://bdeomin"
    
    private var auth: ASWebAuthenticationSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logIn(_ sender: Any) {
        let urlString = "https://api.intra.42.fr/oauth/authorize?client_id=\(UID)&redirect_uri=\(myURL)&response_type=code";
        auth = ASWebAuthenticationSession(url: URL(string: urlString)!, callbackURLScheme: myURL) {
            (data, error) in
            if data != nil {
                let session = URLSession.shared
                let url = NSURL(string: "https://api.intra.42.fr/oauth/token")
                let request = NSMutableURLRequest(url: url! as URL)
                request.httpBody = "grant_type=authorization_code&client_id=\(self.UID)&client_secret=\(self.SECRET)&\((data?.query!)!)&redirect_uri=\(self.myURL)".data(using: String.Encoding.utf8)
                request.httpMethod = "POST"
                session.dataTask(with: request as URLRequest) {
                    (data, res, err) in
                    if err != nil {
                        return
                    }
                    do {
                        if let dict: NSDictionary = try JSONSerialization.jsonObject(with: data!) as? NSDictionary {
                            if let ctoken = dict["access_token"] as? String
                            {
                                catchToken = ctoken
                                DispatchQueue.main.async {
                                    self.performSegue(withIdentifier: "gotoSearch", sender: nil)
                                }
                            }
                        }
                    } catch {
                        print("Error")
                    }
                }.resume()
            }
            else {
                self.presentError(mess: "Not fount any data")
            }
        }
        auth?.presentationContextProvider = self
        auth?.start()
    }
}


@available(iOS 13.0, *)
extension ViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
}

