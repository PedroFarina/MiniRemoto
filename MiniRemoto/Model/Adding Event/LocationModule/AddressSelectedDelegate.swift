//
//  AddressSelectedDelegate.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 27/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import MapKit

public protocol AddressSelectedDelegate {
    func didSelect(address: MKMapItem)
}
