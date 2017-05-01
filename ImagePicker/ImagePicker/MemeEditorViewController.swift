//
//  MemeEditorViewController.swift
//  ImagePicker
//
//  Created by user on 4/22/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var otherTextField: UITextField!
    @IBOutlet weak var shareButton: UIButton!
    
//Meme Struct
    struct Meme{
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
    }
     var newMeme: Meme!
    
//textfield attributes to create meme
     let memeTextAttributes:[String:Any] = [
     NSStrokeColorAttributeName: UIColor.black,
     NSForegroundColorAttributeName: UIColor.white,
     NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
     NSStrokeWidthAttributeName: -6.0]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textField.defaultTextAttributes = memeTextAttributes
        otherTextField.defaultTextAttributes = memeTextAttributes
        textField.text = "BOTTOM"
        otherTextField.text = " TOP"
    
//calls delegate functions to return on hitting return button and clear only default text when editing starts
        textField.delegate = self
        otherTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//enables/disables share and camera buttons
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        if ((imagePickerView.image) == nil) {
           shareButton.isEnabled = false
        } else {
            shareButton.isEnabled = true
        }
    }
    
// UI Text Delegate Functions - clears default text and hides keyboard on hitting Return
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.text == "BOTTOM" || textField.text == " TOP"){
               textField.text = ""
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
//UIImage Picker functions - Album and Camera
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
   
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
//UI Image Picker Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String : Any]){
      //  let image = didFinishPickingMediaWithInfo.index(forKey: "UIImagePickerControllerOriginalImage") as! UIImage
      
        if let image = didFinishPickingMediaWithInfo["UIImagePickerControllerOriginalImage"] as? UIImage {
            imagePickerView.image = image
        }
         picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
//Initializes meme model object
    func save(){
        // Create the meme
        let meme = Meme(topText: otherTextField.text!, bottomText: textField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
    }
    
    func generateMemedImage() -> UIImage {
        //hide navbar and toolbar
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.setToolbarHidden(true, animated: true)
       
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //show navbar and toolbar
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        return memedImage
    }

//Share button action steps
    @IBAction func shareMeme(_ sender: Any) {
        //generate meme
       let memedImage = generateMemedImage()
        
        //define instance of activity view controller and pass memedImage
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        //If the user completes an action in the activity view controller,
        //save the meme to the shared storage.
        activityVC.completionWithItemsHandler = {
            activity, completed, items, error in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        //present the ActivityViewController
        self.present(activityVC, animated: true, completion: nil)
        
      
    }

}
    



