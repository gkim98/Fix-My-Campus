//
//  MapViewController.swift
//  Fix My Campus
//
//  Created by Grant Kim on 12/19/17.
//  Copyright © 2017 2.5 Yellow. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var mapTableView: UITableView!
    @IBOutlet weak var mapContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapTableView.delegate = self
        mapTableView.dataSource = self

        
        mapTableView.register(UINib(nibName: "PostsCell", bundle: nil), forCellReuseIdentifier: "postsCell")
        
    }

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
