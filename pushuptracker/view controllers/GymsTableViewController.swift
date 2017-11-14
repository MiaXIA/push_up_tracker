//
//  GymsTableViewController.swift
//  pushuptracker
//
//  Created by 夏蓦辰 on 2017/11/13.
//  Copyright © 2017年 gwu. All rights reserved.
//

import UIKit

class GymsTableViewController: UITableViewController {
    
    var gyms = [Gym]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gymFinder = GymFinder()
        gymFinder.delegate = self
        gymFinder.fetchNearbyGyms()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gyms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gymCell", for: indexPath) as! GymTableViewCell

        // Configure the cell...
        let gym = gyms[indexPath.row]
        cell.gymNameLabel.text = gym.name
        cell.gymAddressLabel.text = gym.address
        cell.gymLogoImageView.downloadFrom(urlString: gym.logoUrlString)

        return cell
    }
}

extension GymsTableViewController: NearbyGymDelegate {
    func gymsFound(gyms: [Gym]) {
        self.gyms = gyms
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func gymsNotFound() {
        print("no gyms :(")
    }
}
