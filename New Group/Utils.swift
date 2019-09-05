//
//  Utils.swift
//  Quero Conhecer
//
//  Created by Alessandro on 02/09/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit
import MapKit

struct Utils{
    static func showAlert(title: String, message: String, confirmation:Bool, vc: UIViewController){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        if confirmation {
            let confirmAction = UIAlertAction(title: "OK", style: .default) { (action) in
                print("OK")
            }
            alert.addAction(confirmAction)
        }
        alert.addAction(cancelAction)
        vc.present(alert, animated: true)
    }
}
