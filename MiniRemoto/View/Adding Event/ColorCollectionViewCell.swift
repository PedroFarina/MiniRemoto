//
//  ColorCollectionViewCell.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class ColorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var colorView: RoundView!
    public var color: UIColor? {
        get  {
            return colorView.backgroundColor
        }
        set {
            colorView.backgroundColor = newValue
        }
    }
}
