//
//  TimeTableViewCell.swift
//  MiniRemoto
//
//  Created by Felipe Petersen on 27/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class TimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupContent()
    }

    func setupContent() {
        timeLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
        timeLabel.textColor = .black50
        
        self.timeImageView.image = UIImage(named: "clock")
        self.timeImageView.tintColor = .black50
    }
    
       func setup(dayAndTime: String) {
         self.timeLabel.text = dayAndTime
     }
}
