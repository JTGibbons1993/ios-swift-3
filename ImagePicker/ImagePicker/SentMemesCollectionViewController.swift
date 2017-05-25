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
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //Implement flowLayout here ?
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (UIApplication.shared.delegate as! AppDelegate).memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     // deqeue cell
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! CollectionViewCell

     //collect cell data
     let memeImage = (UIApplication.shared.delegate as! AppDelegate).memes[(indexPath as NSIndexPath).row]
     // Set image
     cell.memeImageView.image = memeImage.memedImage
  
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
     let memes = (UIApplication.shared.delegate as! AppDelegate).memes
        print((UIApplication.shared.delegate as! AppDelegate).memes.count)
     // Grab the VC from Storyboard
     let imageVC = storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
     //Populate view controller with data from the selected item
     imageVC.meme = memes[indexPath.row]
     // Present the view controller using navigation
     self.navigationController!.pushViewController(imageVC, animated: true)
    }
    

}
