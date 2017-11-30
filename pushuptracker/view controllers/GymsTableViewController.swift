//
//  GymsTableViewController.swift
//  pushuptracker
//
//  Created by 夏蓦辰 on 2017/11/13.
//  Copyright © 2017年 gwu. All rights reserved.
//

import UIKit
import MBProgressHUD

class GymsTableViewController: UITableViewController {
    
    var gyms = [Gym]()
    let gymFinder = GymFinder()
    let locationFinder = LocationFinder()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //designate self as the receiver of the fetchNearbyGyms callbacks
        gymFinder.delegate = self
        
        locationFinder.delegate = self
        
        findLocation()
    }
    
    func findLocation() {
        //progress bar
        MBProgressHUD.showAdded(to: self.view, animated: true)
        locationFinder.findLocation()
    }
    
    func fetchGyms(latitude: Double, longitude: Double) {
        gymFinder.fetchNearbyGymsUsingCodable(latitude: latitude, longitude: longitude)
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

//adhere to the LocationFinderDelegate protocol
extension GymsTableViewController: LocationFinderDelegate {
    func locationFound(latitude: Double, longitude: Double) {
        fetchGyms(latitude: latitude, longitude: longitude)
    }
    
    func locationNotFound() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        print("location not found.")
    }
}

//adhere to the NearbyGymDelegate protocol
extension GymsTableViewController: NearbyGymDelegate {
    func gymsFound(gyms: [Gym]) {
        self.gyms = gyms
        
        DispatchQueue.main.async {
            MBProgressHUD.hide(for:self.view, animated: true)
            self.tableView.reloadData()
        }
    }
    
    func gymsNotFound(reason: GymFinder.FailureReason) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for:self.view, animated: true)
            
            let alertController = UIAlertController (title: "Problem fetching gyms", message: reason.rawValue, preferredStyle: .alert)
            
            switch reason {
            case .networkRequestFailed:
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                    self.locationFinder.findLocation()
                })
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                alertController.addAction(retryAction)
                alertController.addAction(cancelAction)
            case .badJSONResponse, .noData:
                let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alertController.addAction(okayAction)
            }
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
