//
//  Tweet.swift
//  Day04
//
//  Created by Bogdan DEOMIN on 2/8/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import Foundation

struct Tweet: CustomStringConvertible {
    let name: String
    let date: String
    let text: String
    
    var description: String {
        return ("\(name) \(date) \(text)")
    }
}
