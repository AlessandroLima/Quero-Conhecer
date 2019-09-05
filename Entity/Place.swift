//
//  Place.swift
//  Quero Conhecer
//
//  Created by Alessandro on 31/08/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import MapKit

struct Place: Codable {
    
    let name:String
    let latitude:CLLocationDegrees
    let longitude:CLLocationDegrees
    let address:String
    
    var coordinate: CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
    static func getFormattedAddress(whith placeMark:CLPlacemark) -> String{
        var address = ""
        if let street = placeMark.thoroughfare{
            address += street
        }
        if let number = placeMark.subThoroughfare{
            address += " \(number)"
        }
        if let numsubLocality = placeMark.subLocality{
            address += " \(numsubLocality)"
        }
        if let city = placeMark.locality{
            address += "\n\(city)"
        }
        if let state = placeMark.administrativeArea{
            address += " - \(state)"
        }
        if let postalCode = placeMark.postalCode{
            address += "\n\(postalCode)"
        }
        if let country = placeMark.country{
            address += " \(country)"
        }
        
        return address
    }
}

extension Place: Equatable{
    static func == (lhs:Place,rhs:Place)->Bool{
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
