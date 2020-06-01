//
//  RoundedButton.swift
//  MiniRemoto
//
//  Created by Felipe Petersen on 27/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var roundedCorner: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = roundedCorner
        }
    }
    
    @IBInspectable var strokeLine: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = strokeLine
        }
    }
    
    @IBInspectable var strokeColor: UIColor = .white {
        didSet {
            self.layer.borderColor = strokeColor.cgColor
        }
    }
}
