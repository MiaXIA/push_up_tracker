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
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workouts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)

        // Configure the cell...
        let workout = workouts[indexPath.row]
        cell.textLabel?.text = "\(workout.name) - \(workout.pushupsCompleted)"
        cell.detailTextLabel?.text = workout.startDate.description
        cell.detailTextLabel?.textColor = .gray

        return cell
    }
}
