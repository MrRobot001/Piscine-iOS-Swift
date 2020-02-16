//
//  TableViewCell.swift
//  Day04
//
//  Created by Bogdan DEOMIN on 2/8/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var textLbl: UILabel!
        
    var tweet:Tweet? {
        didSet {
            name.text = tweet!.name
            date.text = tweet!.date
            textLbl.text = tweet!.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
