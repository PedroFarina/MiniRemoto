//
//  LocationData.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class LocationData: Module {
    public static let storyboardName: String = "LocationModule"
    public static let preferredRow: Int = 1
    public var addImage: UIImage? = UIImage(named: "LocationAddModule")
    public var removeImage: UIImage? = UIImage(named: "LocationRemoveModule")
    public var image: UIImage? = UIImage(named: "LocationModule")
    public var title: String? = "Endereço".localized()
    public var subtitle: String? = "Complemento".localized()

    public func isFilled() -> Bool {
        return false
    }
}
