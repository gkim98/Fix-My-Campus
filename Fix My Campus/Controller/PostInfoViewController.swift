//
//  PostInfoViewController.swift
//  Fix My Campus
//
//  Created by Grant Kim on 12/29/17.
//  Copyright © 2017 2.5 Yellow. All rights reserved.
//

import UIKit

class PostInfoViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyTextView: UITextView!
    
    var postsArray: [Post] = [Post]()
    
    // tells you which table cell was tapped
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI() {
        let post = postsArray[index]
        
        userNameLabel.text = post.poster
        dateLabel.text = post.datePosted
        postTitleLabel.text = post.postTitle
        postBodyTextView.text = post.postBody
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
