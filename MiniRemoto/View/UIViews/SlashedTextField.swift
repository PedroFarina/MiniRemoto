//
//  SlashedTextField.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

@IBDesignable public class SlashedTextField: UITextField {
    @IBInspectable public var lineColor: UIColor = .gray {
        didSet {
            setNeedsDisplay()
        }
    }
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        lineColor.setStroke()
        path.lineWidth = 2
        path.stroke()
    }
}
