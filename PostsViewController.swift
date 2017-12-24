//
//  PostsViewController.swift
//  
//
//  Created by Grant Kim on 12/21/17.
//

import UIKit

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var postsTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        postsTableView.register(UINib(nibName: "PostsCell", bundle: nil), forCellReuseIdentifier: "postsCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Methods for implementing table view functionality
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath) as! PostsCell
        
        //test
        let postsArray = ["One", "Two", "Three"]
        
        cell.messageLabel.text = postsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


