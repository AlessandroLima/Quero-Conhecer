//
//  MapViewViewController.swift
//  Quero Conhecer
//
//  Created by Alessandro on 30/08/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit
import MapKit


class MapViewViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var viInfo: UIView!
    @IBOutlet weak var ctSearchBar: NSLayoutConstraint!
    
    //MARK: Properties
    
    var constraint:NSLayoutConstraint?
    
    //MARK: View Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ShowRote(_ sender: UIButton) {
        
    }
    @IBAction func showSearchBar(_ sender: UIBarButtonItem) {
        constraint = ctSearchBar
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1.5) {
            
            if self.ctSearchBar.constant == CGFloat(0){
                self.ctSearchBar.constant = CGFloat(44.0)
            }else{
                self.ctSearchBar.constant = CGFloat(0)
            }
            self.view.layoutIfNeeded()
            
        }
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
