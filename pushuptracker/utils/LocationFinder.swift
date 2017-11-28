//
//  LocationFinder.swift
//  pushuptracker
//
//  Created by 夏蓦辰 on 2017/11/27.
//  Copyright © 2017年 gwu. All rights reserved.
//

import Foundation
import CoreLocation

class LocationFinder: NSObject {
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func findLocation() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            //TO DO
            print("location denied")
        case .authorizedWhenInUse:
            locationManager.requestLocation()
        case .authorizedAlways:
            //do nothing - app can't get to this state
            break
        }
    }
}

extension LocationFinder: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.last!)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //TODO
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
