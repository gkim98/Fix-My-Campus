//
//  MapViewController.swift
//  Fix My Campus
//
//  Created by Grant Kim on 12/19/17.
//  Copyright © 2017 2.5 Yellow. All rights reserved.
//

import UIKit
import GooglePlaces

class MapViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var placesClient: GMSPlacesClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placesClient = GMSPlacesClient.shared()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func getCurrentPlace(_ sender: UIButton) {
        
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            self.nameLabel.text = "No current place"
            self.addressLabel.text = ""
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    self.nameLabel.text = place.name
                    self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
                        .joined(separator: "\n")
                }
            }
        })
        
    }
    

}
