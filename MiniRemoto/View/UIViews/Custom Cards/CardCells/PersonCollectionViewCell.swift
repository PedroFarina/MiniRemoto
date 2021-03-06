//
//  PersonCollectionViewCell.swift
//  MiniRemoto
//
//  Created by Felipe Petersen on 27/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
import MiniRemotoDatabase
import Foundation

class PersonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var circleView: RoundView!
    @IBOutlet weak var initialsLabel: UILabel!
      
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContent()
        setupShadow()
    }
    
    func setup(invitee: Invitee) {
        self.initialsLabel.text = invitee.name?.getFirstCharacters()
    }
    
    func setupContent() {
        self.circleView.backgroundColor = .white50
        self.initialsLabel.textColor = .black50
        
        self.initialsLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
    }
    
    func setupShadow() {
        self.circleView.layer.shadowRadius = 3
        self.circleView.layer.shadowColor = UIColor.black25.cgColor
        self.circleView.layer.shadowOpacity = 0.5
        self.circleView.layer.shadowOffset = .zero
    }
}

public extension String {
    func getFirstCharacters() -> String {
        let cut = self.split(separator: " ")
        var result = ""
        for name in cut {
            result += String(name.prefix(1))
        }
        return result
    }
}
