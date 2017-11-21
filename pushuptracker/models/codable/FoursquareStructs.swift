//
//  FoursquareStructs.swift
//  pushuptracker
//
//  Created by 夏蓦辰 on 2017/11/20.
//  Copyright © 2017年 gwu. All rights reserved.
//

import Foundation

struct Root: Codable {
    let response: Response
}

struct Meta: Codable {
}

struct Response: Codable {
    let venues: [Venues]
}

struct Venues: Codable {
    let id: String
    let name: String
    let location: Location
}

struct Location: Codable {
    let formattedAddress: [String]    
}
