//
//  ViewController.swift
//  pushuptracker
//
//  Created by 夏蓦辰 on 2017/10/16.
//  Copyright © 2017年 gwu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pushUpRecord: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("view did load!")
        
        pushUpRecord.text = "Pushup Record: 50"
    }
    
    @IBAction func trackButtonPressed(_ sender: Any) {
        print("track pushups pressed")
        
        performSegue(withIdentifier: "pushUpSegue", sender: self)
    }

}

