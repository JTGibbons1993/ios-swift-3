//
//  MemeEditorViewController.swift
//  ImagePicker
//
//  Created by user on 4/22/17.
//  Copyright © 2017 Udacity. All rights reserved.
//
import Foundation
import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var otherTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    

    var newMeme: Meme!
    let paragraphStyle = NSMutableParagraphStyle()
    
//textfield attributes to create meme
    let memeTextAttributes:[String:Any] = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        return[
     NSStrokeColorAttributeName: UIColor.black,
     NSForegroundColorAttributeName: UIColor.white,
     NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
     NSStrokeWidthAttributeName: -3.6,
     NSParagraphStyleAttributeName: paragraphStyle] }()
    
    func setupTextField(_ textField: UITextField, defaultText: String) {
        //Formatting
        textField.delegate = self
        textField.text = defaultText
        textField.defaultTextAttributes = memeTextAttributes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //keyboard subscription
          subscribeToKeyboardNotifications()
        // text field attributes
        setupTextField(otherTextField, defaultText: "TOP")
        setupTextField(textField, defaultText: "BOTTOM")
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
        if (textField.text == "BOTTOM" || textField.text == "TOP"){
               textField.text = ""
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
//sign up to be notified when the keyboard appears
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
//When the keyboardWillShow notification is received, shift the view's frame up
    func keyboardWillShow(_ notification:Notification) {
        if textField.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
//Shift the view frame back down to 0
    func keyboardWillHide(_ notification:Notification) {
        if textField.isFirstResponder{
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
//UIImage Picker functions - Album and Camera
    func presentImagePicker(_ chosenSource: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        //choose source for photos
        imagePicker.sourceType = chosenSource
    }
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        presentImagePicker(.photoLibrary)
    }
   
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        presentImagePicker(.camera)
    }
    
//UI Image Picker Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String : Any]){
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
// Add saved meme to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
             appDelegate.memes.append(meme)
    }
    
    func navAndToolBarHide(_ hide: Bool){
        self.navigationController?.setNavigationBarHidden(hide, animated: hide)
        toolBar.isHidden = hide
        albumButton.accessibilityElementsHidden = hide
        cameraButton.accessibilityElementsHidden = hide
        
    }
    func generateMemedImage() -> UIImage {
//hide navbar and toolbar
        navAndToolBarHide(true)
// Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
//show navbar and toolbar
        navAndToolBarHide(false)
        
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
    
//Meme Struct
struct Meme{
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
}


