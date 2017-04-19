//
//  TableViewCell.swift
//  parseJson
//
//  Created by Rea Won Kim on 4/5/17.
//  Copyright © 2017 Rea Won Kim. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var textTxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
