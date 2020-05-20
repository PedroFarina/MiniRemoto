//
//  ModuleCollectionViewCell.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class ModuleCollectionViewCell: UICollectionViewCell {
    public weak var module: Module? {
        didSet {
            img = module?.addImage
        }
    }

    public func switchImage() -> Bool {
        if img === module?.addImage {
            img = module?.removeImage
            return true
        } else {
            img = module?.addImage
            return false
        }
    }

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
