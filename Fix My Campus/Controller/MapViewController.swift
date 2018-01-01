//
//  MapViewController.swift
//  Fix My Campus
//
//  Created by Grant Kim on 12/19/17.
//  Copyright © 2017 2.5 Yellow. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView.camera = camera
        mapView.delegate = self

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.map = mapView
    
        mapTableView.delegate = self
        mapTableView.dataSource = self
        mapTableView.register(UINib(nibName: "PostsCell", bundle: nil), forCellReuseIdentifier: "postsCell")
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("a marker was tapped")
        marker.opacity = 0.6
        return true
    }

    
    //MARK: - Methods for the table view functionality
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath) as! PostsCell
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
}

