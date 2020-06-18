//
//  MainCollectionViewCell.swift
//  To Do list
//
//  Created by Chihiro Nishiwaki on 2020/06/17.
//  Copyright © 2020 Nishiwaki sen. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var nameLabel: UILabel!
       @IBOutlet var dateLabel: UILabel!
       @IBOutlet var deadlineLabel: UILabel!
       
       //cell自体の設定
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           
           //self.layer.borderWidth = 1.0
           //self.layer.borderColor = UIColor.darkGray.cgColor
           
           self.layer.cornerRadius = 10
           
       }
    
}
