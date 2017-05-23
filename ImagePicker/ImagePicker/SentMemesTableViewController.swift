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
   
    @IBOutlet var memeTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        memeTableView.reloadData()
    }

    //Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (UIApplication.shared.delegate as! AppDelegate).memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // deqeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
    //collect cell data
        let memeImage = (UIApplication.shared.delegate as! AppDelegate).memes[(indexPath as NSIndexPath).row]
    // Set image
         cell.imageView!.image = memeImage.memedImage
    //detail text
        cell.textLabel?.text = "\(memeImage.topText) / \(memeImage.bottomText)"
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memes = (UIApplication.shared.delegate as! AppDelegate).memes
    // Grab the VC from Storyboard
        let imageVC = storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
    //Populate view controller with data from the selected item
        imageVC.meme = memes[indexPath.row]
    // Present the view controller using navigation
        self.navigationController!.pushViewController(imageVC, animated: true)
    }

}
