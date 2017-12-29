//
//  AddPostViewController.swift
//  Fix My Campus
//
//  Created by Grant Kim on 12/29/17.
//  Copyright © 2017 2.5 Yellow. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var addPostImage: UIImageView!
    @IBOutlet weak var problemTitleTextField: UITextField!
    @IBOutlet weak var problemBodyTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // image picker
        addPostImage.isUserInteractionEnabled = true
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(self.chooseImage))
        addPostImage.addGestureRecognizer(imageGesture)
    }
    
    //MARK: - text
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // add some kind of field for if the post actually has an image --> changes the type of view controller that is presented
    
    
    //MARK: - image picker
    
    @objc func chooseImage() {
        
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        addPostImage.image = image
        
        dismiss(animated: true, completion: nil)
    }

    
    //MARK: - cancel and submit
    @IBAction func submitButton(_ sender: UIButton) {
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
