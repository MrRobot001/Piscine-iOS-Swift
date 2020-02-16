//
//  TwitterDelegate.swift
//  Day04
//
//  Created by Bogdan DEOMIN on 2/8/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import Foundation

protocol APITwitterDelegate: class {
    func processTweets(tweets: [Tweet])
    func handleError(error: NSError)
}
