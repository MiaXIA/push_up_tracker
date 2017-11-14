//
//  Gym.swift
//  pushuptracker
//
//  Created by 夏蓦辰 on 2017/11/13.
//  Copyright © 2017年 gwu. All rights reserved.
//

import Foundation

struct Gym {
    let name: String
    let address: String
    let logoUrlString: String
    
    enum CodingKeys: String, CodingKey {
        case name //matches above
        case address //matches above
        case logoUrlString = "image_url"
    }
}
