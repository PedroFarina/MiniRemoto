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
        // Initialization code
    }

       func setup(dayAndTime: String) {
         self.timeLabel.text = dayAndTime
     }
     
    
}
