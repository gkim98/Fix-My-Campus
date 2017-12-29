//
//  AddPostViewController.swift
//  Fix My Campus
//
//  Created by Grant Kim on 12/29/17.
//  Copyright © 2017 2.5 Yellow. All rights reserved.
//

import UIKit
import Firebase

class AddPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var addPostImage: UIImageView!
    @IBOutlet weak var problemTitleTextField: UITextField!
    @IBOutlet weak var problemBodyTextField: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // image picker
        addPostImage.isUserInteractionEnabled = true
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(self.chooseImage))
        addPostImage.addGestureRecognizer(imageGesture)
    }
    
    
    //MARK: - text
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // collapses keyboard
        self.view.endEditing(true)
    }
    
    
    
    //MARK: - image picker
    
    @objc func chooseImage() {
        
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    // add some field for picture not chosen --> picture = false
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // changes default image to chosen image
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        addPostImage.image = image
        
        dismiss(animated: true, completion: nil)
    }

    
    //MARK: - cancel and submit
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        // collapses keyboard if submit is pressed
        problemBodyTextField.endEditing(true)
        problemTitleTextField.endEditing(true)
        
        // UI components can not be interacted with if submit is pressed
        problemTitleTextField.isEnabled = false
        problemBodyTextField.isEditable = false
        submitButton.isEnabled = false
        cancelButton.isEnabled = false
        
        // saves the post to the database
        let postsDB = Database.database().reference().child("Posts")
        
        let postsDictionary = [
            "Sender": "Jim",
            "Title": problemTitleTextField.text!,
            "Body": problemBodyTextField.text!
        ]
        
        postsDB.childByAutoId().setValue(postsDictionary) {
            (error, reference) in

            if error != nil {
                print(error!)
            } else {
                print("post successfully recorded")
            }
        }
        
        // dismisses the modal view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
        // collapses view of modal view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
