//
//  MapViewController.swift
//  Fix My Campus
//
//  Created by Grant Kim on 12/19/17.
//  Copyright © 2017 2.5 Yellow. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class MapViewController: UIViewController, GMSMapViewDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapTableView: UITableView!
    
    let screenSize:CGRect = UIScreen.main.bounds
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    
    var markers: [GMSMarker] = []
    var likelyPlaces: [GMSPlace] = []
    var selectedPlace: GMSPlace?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultLocation = CLLocation(latitude: 0, longitude: 0)
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude, zoom: zoomLevel)
        
        setupLocationManager()
        setupTableView()
        
        addMarker(xcoord: 36.003522, ycoord: -78.933009)
        addMarker(xcoord: 36.002584, ycoord: -78.937000)
        addMarker(xcoord: 36.000189, ycoord: -78.938502)

        
    }
    
    
    
    
    //MARK: - Methods for marker functionality
    func addMarker(xcoord: CLLocationDegrees, ycoord: CLLocationDegrees) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: xcoord, longitude: ycoord)
        marker.map = mapView
        markers.append(marker)
    }

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height * 0.7)
        marker.opacity = 0.6
        return true
    }
    
    
    
    //MARK: - Methods for the table view functionality
    func setupTableView() {
        mapTableView.delegate = self
        mapTableView.dataSource = self
        mapTableView.register(UINib(nibName: "PostsCell", bundle: nil), forCellReuseIdentifier: "postsCell")
    }
    
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
    
    
    
    //MARK: - Location Manager
    // configuration for location manager and other setup for the map
    func setupLocationManager() {
        mapView.delegate = self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        placesClient = GMSPlacesClient.shared()
        
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // mapView.isMyLocationEnabled = true
        mapView.isHidden = true
    }
    
    // handles events for the location manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
        //listLikelyPlaces()
    }
    
    // handles authorization for location manager
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // handle location manager errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    
}

