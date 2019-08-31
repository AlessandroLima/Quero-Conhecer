//
//  PlaceFinderViewController.swift
//  Quero Conhecer
//
//  Created by Alessandro on 30/08/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit
import MapKit

class PlaceFinderViewController: UIViewController {

    //MARK:Outlets
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    //MARK:Properties
    
    let geoCoder = CLGeocoder()
    
    
    //MARK:View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func findPlace(_ sender: UIButton) {
        txtSearch.resignFirstResponder()
        let place = txtSearch.text
        load(show: true)
        if let place = place{
            geoCoder.geocodeAddressString(place) { (placeMarks, error) in
                self.load(show: false)
            }
        }
        
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}

extension PlaceFinderViewController{
    
    //MARK:Functions
    func load(show:Bool){
            viewLoading.isHidden = !show
        if show{
            loading.startAnimating()
        }else{
            loading.stopAnimating()
        }
    }
}
