//
//  UIImageViewExtension.swift
//  pushuptracker
//
//  Created by 夏蓦辰 on 2017/11/13.
//  Copyright © 2017年 gwu. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadFrom(urlString: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    return
            }
            DispatchQueue.main.async {
               self.image = image
            }
        }.resume()
    }
}
