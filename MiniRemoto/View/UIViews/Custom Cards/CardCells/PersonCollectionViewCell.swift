//
//  PersonCollectionViewCell.swift
//  MiniRemoto
//
//  Created by Felipe Petersen on 27/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var circleView: RoundView!
    @IBOutlet weak var initialsLabel: UILabel!
      
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContent()
        setupShadow()
    }
    
    func setupContent() {
        self.circleView.backgroundColor = .white50()
        self.initialsLabel.textColor = .black50()
        
        self.initialsLabel.font = UIFont(name: "Montserrat-Medium", size: 14)
    }
    
    func setupShadow() {
        self.circleView.layer.shadowRadius = 3
        self.circleView.layer.shadowColor = UIColor.black25().cgColor
        self.circleView.layer.shadowOffset = .zero
        
    }

}
