//
//  PlaceFinderViewController.swift
//  Quero Conhecer
//
//  Created by Alessandro on 30/08/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit
import MapKit

protocol PlaceFinderDelegate: class{
    func addPlace(_ place:Place)
}

class PlaceFinderViewController: UIViewController, PlaceFinderDelegate {
    
    
    
    enum placeFinderMessageType {
        case error(String)
        case confirmation(String)
    }
    
    //MARK:Outlets
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    //MARK:Properties
    
    let geoCoder = CLGeocoder()
    var place: Place!
    let ud = UserDefaults.standard
    weak var delegate:PlaceFinderDelegate?
    
    
    //MARK:View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(getLocation(_:)))
        gesture.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(gesture)
    }
    
    @IBAction func findPlace(_ sender: UIButton) {
        txtSearch.resignFirstResponder()
        let place = txtSearch.text
        load(show: true)
        if let place = place{
            geoCoder.geocodeAddressString(place) { (placeMarks, error) in
                self.load(show: false)
                if error == nil{
                    if !self.savePlace(placeMark: placeMarks?.first){
                        self.setMessage(type: .error("Erro desconhecido."))
                    }
                }else{
                    self.setMessage(type: .error("Não encontramos nenhum local com esse nome."))
                }
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
    
    func savePlace(placeMark:CLPlacemark?) -> Bool{
        guard let placeMark = placeMark , let coordinate = placeMark.location?.coordinate else {
            setMessage(type: .error("Erro ao localizar"))
            return false
        }
        let name = placeMark.name ?? placeMark.country ?? "Desconhecido"
        let address = Place.getFormattedAddress(whith: placeMark)
        place = Place(name:name,latitude:coordinate.latitude,longitude:coordinate.longitude,address:address)
        
        showInMap(place: place)
        return true
    }
    
    func showInMap(place:Place){
        
        let region = MKCoordinateRegion(center: place.coordinate, latitudinalMeters: 3500, longitudinalMeters: 3500)
        mapView.setRegion(region, animated: true)
        setMessage(type: .confirmation(place.name))
    }
    
    func setMessage(type:placeFinderMessageType){
        let title:String, message:String
        var hasConfirmation:Bool = false
        
        switch type {
            
        case .confirmation(let name):
            title = "Local encontrado"
            message = "Deseja adcionar \(name)?"
            hasConfirmation = true
        case .error(let errorMessage):
            title = "Erro"
            message = errorMessage
            hasConfirmation = false
        }
        showAlert(title: title, message: message, confirmation: hasConfirmation, vc: self)
    }
    
    @objc func getLocation(_ gesture:UILongPressGestureRecognizer){
        if gesture.state == .began{
            load(show: true)
            let point = gesture.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            geoCoder.reverseGeocodeLocation(location) { (placeMarks, error) in
                self.load(show: false)
                if error == nil{
                    if !self.savePlace(placeMark: placeMarks?.first){
                        self.setMessage(type: .error("Erro desconhecido."))
                    }
                }else{
                    self.setMessage(type: .error("Não encontramos nenhum local com esse nome."))
                }
            }
        }
    }
    
    func showAlert(title: String, message: String, confirmation:Bool, vc: UIViewController){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        if confirmation {
            let confirmAction = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
                self.addPlace(self.place)
            }
            alert.addAction(confirmAction)
        }
        alert.addAction(cancelAction)
        vc.present(alert, animated: true)
    }
    
    func addPlace(_ place: Place) {
        delegate?.addPlace(place)
    }
}
