//
//  SentMemesCollectionViewController.swift
//  ImagePicker
//
//  Created by user on 5/18/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController{
    
    let memes = (UIApplication.shared.delegate as! AppDelegate).memes
    @IBOutlet var memeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //Implement flowLayout here ?
        memeCollectionView.delegate = self
        memeCollectionView.reloadData()
    }
    
/*
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (UIApplication.shared.delegate as! AppDelegate).memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Grab the VC from Storyboard
        //Populate view controller with data from the selected item
        // Present the view controller using navigation
    }
    
*/
}
