//
//  Place.swift
//  Quero Conhecer
//
//  Created by Alessandro on 30/08/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import MapKit

struct PlaceEntity{
    var name:String
    var latitude:CLLocationDegrees
    var logitude:CLLocationDegrees
    var address:String
    var coordenate:CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: latitude, longitude: logitude)
    }
}
