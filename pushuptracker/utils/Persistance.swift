//
//  Persistance.swift
//  pushuptracker
//
//  Created by 夏蓦辰 on 2017/10/30.
//  Copyright © 2017年 gwu. All rights reserved.
//

import Foundation

class Persistance {
    static let sharedInstance = Persistance()
    
    let workoutsKey = "workouts"
    
    func fetchBestWorkout() -> Workout? {
        let workouts = fetchWorkouts()
        
        let sortedWorkouts = workouts.sorted(by: { $0.pushupsCompleted > $1.pushupsCompleted })
        
        return sortedWorkouts.first
    }
    
    func fetchWorkouts() -> [Workout] {
        let userDefaults = UserDefaults.standard
        
        let data = userDefaults.object(forKey: workoutsKey) as? Data
        
        if let data = data {
            //data is not nil, so use it
            return NSKeyedUnarchiver.unarchiveObject(with: data) as! [Workout]
        } else {
            //data is nil
            return [Workout]()
        }
    }
    
    func saveWorkout(_ workout: Workout) {
        let userDefaults = UserDefaults.standard
        
        var workouts = fetchWorkouts()
        workouts.append(workout)
        
        let data = NSKeyedArchiver.archivedData(withRootObject: workouts)
        
        userDefaults.set(data, forKey: workoutsKey)
    }
}
