//
//  SaveListTableViewCell.swift
//  To Do list
//
//  Created by Chihiro Nishiwaki on 2020/05/24.
//  Copyright © 2020 Nishiwaki sen. All rights reserved.
//

import UIKit

class SaveListTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var submitDate: UILabel!
    @IBOutlet var importance: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
