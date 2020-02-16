//
//  ListTableViewCell.swift
//  Day05
//
//  Created by Bogdan DEOMIN on 2/11/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
