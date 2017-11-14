//
//  GymTableViewCell.swift
//  pushuptracker
//
//  Created by 夏蓦辰 on 2017/11/13.
//  Copyright © 2017年 gwu. All rights reserved.
//

import UIKit

class GymTableViewCell: UITableViewCell {

    @IBOutlet weak var gymNameLabel: UILabel!
    @IBOutlet weak var gymAddressLabel: UILabel!
    @IBOutlet weak var gymLogoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
