//
//  ShopMarker.swift
//  HealthyFood
//
//  Created by Sorrapong W on 14/3/2563 BE.
//  Copyright © 2563 Sorrapong W. All rights reserved.
//

import UIKit
import GoogleMaps

class ShopMarker: GMSMarker {
    let place : GooglePlace
    
    init(place: GooglePlace) {
       self.place = place
       super.init()

       position = place.coordinate
       icon = UIImage(named: place.placeType+"_pin")
       groundAnchor = CGPoint(x: 0.5, y: 1)
       appearAnimation = .pop
     }
}
