//
//  SentMemesTableViewController.swift
//  ImagePicker
//
//  Created by user on 5/18/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    let memes = (UIApplication.shared.delegate as! AppDelegate).memes
    @IBOutlet var memeTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        memeTableView.delegate = self
        memeTableView.reloadData()
    }

    //Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // deqeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
        //collect cell data
        let memeImage = (UIApplication.shared.delegate as! AppDelegate).memes[(indexPath as NSIndexPath).row]
        // Set image
         cell.imageView!.image = memeImage.memedImage

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Grab the VC from Storyboard  
      let editorVC = storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
         //Populate view controller with data from the selected item
      editorVC.meme = memes[indexPath.row]
        // Present the view controller using navigation
      self.navigationController!.pushViewController(editorVC, animated: true)
    }

}
