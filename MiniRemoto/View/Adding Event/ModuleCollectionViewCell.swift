//
//  ModuleCollectionViewCell.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class ModuleCollectionViewCell: UICollectionViewCell {
    public var img: UIImage? {
        get {
            return imgView.image
        }
        set {
            imgView.image = newValue
        }
    }
    @IBOutlet weak var imgView: UIImageView!
}
