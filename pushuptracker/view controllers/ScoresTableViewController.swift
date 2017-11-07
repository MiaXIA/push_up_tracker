//
//  ScoresTableViewController.swift
//  pushuptracker
//
//  Created by 夏蓦辰 on 2017/11/6.
//  Copyright © 2017年 gwu. All rights reserved.
//

import UIKit

class ScoresTableViewController: UITableViewController {
    
    var workouts:[Workout]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        workouts = Persistance.sharedInstance.fetchWorkouts()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workouts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = "\(workouts[indexPath.row].pushupsCompleted)"

        return cell
    }
}