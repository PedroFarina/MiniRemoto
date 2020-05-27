//
//  AddressTableViewCell.swift
//  MiniRemoto
//
//  Created by Felipe Petersen on 27/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContent()
    }
    
    func setup() {
    }
    
    func setupContent() {
        self.addressNameLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
        self.addressLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        self.rideButtonOutlet.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        
        self.addressImageView.image = UIImage(named: "Location")
        self.addressImageView.tintColor = .black50()
        
        self.addressNameLabel.textColor = .black50()
        self.addressLabel.textColor = .black50()
        self.rideButtonOutlet.strokeColor = .black50()
        self.rideButtonOutlet.setTitleColor(.black50(), for: .normal)
        
//        self.rideButtonOutlet.imageView = UIImage(named: "uber")
        self.rideButtonOutlet.setImage(UIImage(named: "uber"), for: .normal)
        self.rideButtonOutlet.imageView?.tintColor = .black50()
    }
    
}
