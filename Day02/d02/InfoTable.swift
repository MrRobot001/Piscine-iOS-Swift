//
//  InfoTable.swift
//  d02
//
//  Created by Mykola ZHURBA on 10/2/19.
//  Copyright © 2019 mzhurba. All rights reserved.
//

import UIKit

internal class InfoTable: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    var info: (name: String, description: String, date: String)? {
        didSet {
            if let new = info {
                nameLbl?.text = new.name
                descriptionLbl?.text = new.description
                dateLbl?.text = new.date
            }
        }
    }
}
