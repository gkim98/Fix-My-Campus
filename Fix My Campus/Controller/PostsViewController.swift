//
//  PostsViewController.swift
//
//
//  Created by Grant Kim on 12/21/17.
//

import UIKit
import Firebase

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var postsArray = [Post]()
    
    // tells you which table cell was tapped
    var indexTapped = 0
    
    @IBOutlet weak var postsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(UINib(nibName: "PostsCell", bundle: nil), forCellReuseIdentifier: "postsCell")
        
        retrievePosts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postMoreInfo" {
            
            let postInfoVC = segue.destination as! PostInfoViewController
            postInfoVC.postsArray = postsArray
            postInfoVC.index = indexTapped
        }
    }
    
    
    //MARK: - interaction with the database
    
    func retrievePosts() {
        let messageDB = Database.database().reference().child("Posts")
        
        // make sure that this is appending every post to the array
        messageDB.observe(.childAdded) {(snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,Any>
            
            let poster = snapshotValue["Poster"]!
            let postTitle = snapshotValue["Post Title"]!
            let postBody = snapshotValue["Post Body"]!
            let isResolved = snapshotValue["Resolved"]!
            let datePosted = snapshotValue["Date Posted"]!
            
            let post = Post();
            post.poster = poster as! String
            post.postTitle = postTitle as! String
            post.postBody = postBody as! String
            post.isResolved = isResolved as! Bool
            post.datePosted = datePosted as! String
            
            self.postsArray.append(post)
            
            self.configureTableView()
            self.postsTableView.reloadData()
        }
    }
    
    
    //MARK: - table view set up
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath) as! PostsCell
        
        cell.userNameLabel.text = postsArray[indexPath.row].poster
        cell.postTitleLabel.text = postsArray[indexPath.row].postTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        indexTapped = indexPath.row
        performSegue(withIdentifier: "postMoreInfo", sender: self)
    }
    
    func configureTableView() {
        postsTableView.rowHeight = UITableViewAutomaticDimension
        postsTableView.estimatedRowHeight = 120.0
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
