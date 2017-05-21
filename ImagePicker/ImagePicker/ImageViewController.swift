//
//  ImageViewController.swift
//  ImagePicker
//
//  Created by user on 5/21/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageVC: UIImageView!
    var meme: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        imageVC.image = meme.memedImage
    }
}
