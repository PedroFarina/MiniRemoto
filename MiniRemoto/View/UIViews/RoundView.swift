//
//  CircleView.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

@IBDesignable public class RoundView: UIView {
    @IBInspectable public var isCircled: Bool = false {
        willSet {
            if newValue {
                radius = frame.width/2
            }
        }
    }
    @IBInspectable public var radius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
}
