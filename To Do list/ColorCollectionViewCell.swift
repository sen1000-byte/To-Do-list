//
//  ColorCollectionViewCell.swift
//  To Do list
//
//  Created by Chihiro Nishiwaki on 2020/06/06.
//  Copyright © 2020 Nishiwaki sen. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    @IBOutlet var colorcircle: UILabel!
    @IBOutlet var name: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.darkGray.cgColor
        
        self.layer.cornerRadius = 10
        
    }
    //required init?(coder aDecoder: NSCoder) {
    //super.init(coder: aDecoder)

    
}
