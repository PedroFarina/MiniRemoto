//
//  AddressTableViewCell.swift
//  UtilidadeTeste
//
//  Created by Felipe Petersen on 26/05/20.
//  Copyright © 2020 Felipe Petersen. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var addressImageView: UIImageView!
    @IBOutlet weak var addressNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var rideButtonOutlet: RoundedButton!
    
   
    @IBAction func didTapRide(_ sender: Any) {
        //TODO: Ride with Uber
    }
    
    func setup(color: UIColor) {
        self.addressNameLabel.textColor = color
        self.addressLabel.textColor = color
        self.rideButtonOutlet.strokeColor = color
//        self.rideButtonOutlet.titleLabel?.textColor = color
        self.rideButtonOutlet.setTitleColor(color, for: .normal	)
    }
    
}
