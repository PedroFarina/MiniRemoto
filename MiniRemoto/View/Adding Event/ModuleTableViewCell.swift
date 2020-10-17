//
//  ModuleTableViewCell.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class ModuleTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!

    public weak var module: Module? {
        didSet {
            img = module?.image
            title = module?.title
            subtitle = module?.subtitle
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

    public var title: String? {
        get {
            return lblTitle.text
        }
        set {
            lblTitle.text = newValue
        }
    }

    public var subtitle: String?  {
        get {
            return lblSubtitle.text
        }
        set {
            lblSubtitle.text = newValue
        }
    }
}
