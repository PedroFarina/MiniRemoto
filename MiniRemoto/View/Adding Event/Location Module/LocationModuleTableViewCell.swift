//
//  LocationModuleTableViewCell.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 27/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
import MapKit

public class LocationModuleTableViewCell: UITableViewCell {
    var mapItem: MKMapItem? {
        willSet {
            if let value = newValue {
                let placemark = value.placemark
                textLabel?.text = placemark.name
                detailTextLabel?.text = LocationHelper.getFullAddress(from: placemark)
            } else {
                textLabel?.text = ""
                detailTextLabel?.text = ""
            }
        }
    }
}
