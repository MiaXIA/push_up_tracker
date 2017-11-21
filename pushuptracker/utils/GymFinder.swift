//
//  GymFinder.swift
//  pushuptracker
//
//  Created by 夏蓦辰 on 2017/11/13.
//  Copyright © 2017年 gwu. All rights reserved.
//

import Foundation

protocol NearbyGymDelegate {
    func gymsFound(gyms: [Gym])
    func gymsNotFound()
}

class GymFinder {
    
    var delegate: NearbyGymDelegate?
    
    func fetchNearbyGymsUsingCodable(latitude: Double, longitude: Double) {
        var urlComponents = URLComponents(string: "https://api.foursquare.com/v2/venues/search")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_secret", value: "H20WAGEG5C2YIIP2QJG0CDNMZQ0O0YBECFTUY4ADZQKQCQUS"),
            URLQueryItem(name: "client_id", value: "KUS3LGMRRJVOP14XPVSVHPHZ5HA00AT40FTIEBSYMWTET40F"),
            URLQueryItem(name: "v", value: "20171113"),
            URLQueryItem(name: "ll", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "query", value: "gym")
        ]
        
        let url = urlComponents.url!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) {
            (data,response, error) in
        
            //check for valid response with 200 (success)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self.delegate?.gymsNotFound()
                
                return
            }
            
            guard let data = data else {
                self.delegate?.gymsNotFound()
                
                return
            }
            
            //TODO: use codable to parse JSON
            let decoder = JSONDecoder()
            let rootData = try? decoder.decode(Root.self, from: data)
            
            guard let root = rootData else {
                self.delegate?.gymsNotFound()
                
                return
            }
            
            var gyms = [Gym]()
            let venues = root.response.venues
            for venue in venues {
                let gym = Gym(name: venue.name, address: venue.location.formattedAddress.joined(separator: " "), logoUrlString: "")
                gyms.append(gym)
            }
            
            self.delegate?.gymsFound(gyms: gyms)
        }
        
        task.resume()
    }
    
    func fetchNearbyGyms(latitude: Double, longitude: Double) {
        var urlComponents = URLComponents(string: "https://api.foursquare.com/v2/venues/search")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_secret", value: "H20WAGEG5C2YIIP2QJG0CDNMZQ0O0YBECFTUY4ADZQKQCQUS"),
            URLQueryItem(name: "client_id", value: "KUS3LGMRRJVOP14XPVSVHPHZ5HA00AT40FTIEBSYMWTET40F"),
            URLQueryItem(name: "v", value: "20171113"),
            URLQueryItem(name: "ll", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "query", value: "gym")
        ]
        
        let url = urlComponents.url!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) {
            (data,response, error) in
            //TODO: handle response
            
            //check for valid response with 200 (success)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self.delegate?.gymsNotFound()
                
                return
            }
            
            //check if new data exist
            guard let data = data, let foursquareJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [String: Any]() else {
                self.delegate?.gymsNotFound()
                
                return
            }
            
            guard let responseJsonObject = foursquareJsonObject["response"] as? [String: Any], let venuesJsonArrayObject = responseJsonObject["venues"] as? [[String: Any]] else {
                self.delegate?.gymsNotFound()
                
                return
            }
            
            var gyms = [Gym]()
            for venuesJsonArrayObject in venuesJsonArrayObject {
                let name = venuesJsonArrayObject["name"] as? String ?? ""
                let location = venuesJsonArrayObject["location"] as? [String:Any]
                if let location = location {
                    let address = location["address"] as? String
                    if let address = address {
                        let gym = Gym(name: name, address: address, logoUrlString: "")
                        gyms.append(gym)
                    }
                }
            }
            
            self.delegate?.gymsFound(gyms: gyms)
        }
        
        task.resume()
    }
    
    //fake gym data codes
    func fetchNearbyGyms() {
        let requestURL = URL(string: "https://s3.amazonaws.com/files.jared-alexander.com/fake_gym_data/gymdata.json")!
        let urlRequest = URLRequest(url: requestURL)
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) -> Void in
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {//200 = success
                if let data = data, let gymJsonArray = try? JSONSerialization.jsonObject(with: data, options: []) {
                    
                    if let gymJsonArray = gymJsonArray as? [[String:Any]] {
                        var gyms = [Gym]()
                        
                        for gymJsonObject in gymJsonArray {
                            //TODO: parse data from JSON
                            let gymName = gymJsonObject["name"] as? String ?? ""
                            let gymAddress = gymJsonObject["address"] as? String ?? ""
                            let gymImageUrl = gymJsonObject["image_url"] as? String ?? ""
                            
                            let gym = Gym(name: gymName, address: gymAddress, logoUrlString: gymImageUrl)
                            gyms.append(gym)
                        }
                        //TODO: handle success
                        self.delegate?.gymsFound(gyms: gyms)
                    }
                    else {
                        //TODO: handle failure
                        self.delegate?.gymsNotFound()
                    }
                }
                else {
                    //TODO: handle failure
                    self.delegate?.gymsNotFound()
                }
            }
            else {
                //TODO: handle failure
                self.delegate?.gymsNotFound()
            }
        }
        task.resume()
    }
    
    private func gymsFromJsonData(data: Data) -> [Gym] {
        let decoder = JSONDecoder()
        let gyms = try? decoder.decode([Gym].self, from: data)
        
        return gyms ?? [Gym]()
    }
}
