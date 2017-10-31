//
//  Workout.swift
//  pushuptracker
//
//  Created by 夏蓦辰 on 2017/10/30.
//  Copyright © 2017年 gwu. All rights reserved.
//

import Foundation

class Workout: NSObject {
    let name: String
    let pushupsCompleted: Int
    let startDate: Date
    
    let nameKey = "name"
    let startDateKey = "startDate"
    let pushupsCompletedKey = "pushupsCompleted"
    
    init(name: String, pushupsCompleted: Int, startDate: Date) {
        
        self.name = name
        self.pushupsCompleted = pushupsCompleted
        self.startDate = startDate
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: nameKey) as! String
        startDate = aDecoder.decodeObject(forKey: startDateKey) as! Date
        pushupsCompleted = aDecoder.decodeInteger(forKey: pushupsCompletedKey)
    }
}

extension Workout: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(startDate, forKey: startDateKey)
        aCoder.encode(pushupsCompleted, forKey: pushupsCompletedKey)
    }
}
