//
//  ItemsListTableViewCell.swift
//  MiniRemoto
//
//  Created by Felipe Petersen on 28/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
import MiniRemotoDatabase

class ItemsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectionButtonOutlet: RoundedButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var personNameLabel: UILabel!
    
    var alreadySelected = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContent()
        // Initialization code
    }

    func setupContent() {
        self.nameLabel.font = UIFont(name: "Montserrat-Medium", size: 14)
        self.nameLabel.textColor = .black50
        self.lineView.backgroundColor = .black50
        self.personNameLabel.font = UIFont(name: "Montserrat-Medium", size: 10)
        self.personNameLabel.textColor = .black50
        self.selectionButtonOutlet.tintColor = .black50
        
        if alreadySelected {
            self.selectionButtonOutlet.strokeColor = .black50
            self.selectionButtonOutlet.setImage(nil, for: .normal)
//            self.personNameLabel.isHidden = true
        } else {
            self.selectionButtonOutlet.strokeColor = .clear
            self.selectionButtonOutlet.setImage(UIImage(named: "check_item"), for: .normal)
//            self.personNameLabel.isHidden = false
        }
    }
    
    func setup(item: Item) {
        self.nameLabel.text = item.name
    }
    
    
    
}
