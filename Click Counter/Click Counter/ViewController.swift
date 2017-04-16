//
//  ViewController.swift
//  Click Counter
//
//  Created by user on 4/16/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var count = 0
    @IBOutlet var label:UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
    }

    @IBAction func incrementCount() {
        self.count += 1
        self.label.text = "\(self.count)"
    }

}

