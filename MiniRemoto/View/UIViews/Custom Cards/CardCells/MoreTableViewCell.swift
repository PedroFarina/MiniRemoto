//
//  MoreTableViewCell.swift
//  MiniRemoto
//
//  Created by Felipe Petersen on 28/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var moreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupContent()
    }
    
    func setupContent() {
        self.backView.backgroundColor = .black25()
        self.moreLabel.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        self.moreLabel.textColor = .black50()
        self.moreLabel.text = "Ver mais"
    }

    
}
