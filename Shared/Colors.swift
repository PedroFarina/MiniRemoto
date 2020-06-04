//
//  Colors.swift
//  MiniRemoto
//
//  Created by Felipe Petersen on 27/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    static var black50: UIColor
    {
        return UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha:0.5)
    }
    
    static var black25: UIColor
    {
        return UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha:0.25)
    }
    
    static var white50: UIColor
    {
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha:0.5)
    }

    static var redCard: UIColor
    {
        return UIColor(red: 231.0/255.0, green: 80.0/255.0, blue: 70.0/255.0, alpha:1.0)
    }
    
    static var orangeCard: UIColor
    {
        return UIColor(red: 242.0/255.0, green: 160.0/255.0, blue: 57.0/255.0, alpha:1.0)
    }
    
    static var blueCard: UIColor
    {
        return UIColor(red: 129.0/255.0, green: 197.0/255.0, blue: 190.0/255.0, alpha:1.0)
    }
    
    static var pinkCard: UIColor
    {
        return UIColor(red: 242.0/255.0, green: 169.0/255.0, blue: 157.0/255.0, alpha:1.0)
    }
    
    static var yellowCard: UIColor
    {
        return UIColor(red: 236.0/255.0, green: 206.0/255.0, blue: 74.0/255.0, alpha:1.0)
    }
    
    static var lightBlueCard: UIColor
    {
        return UIColor(red: 131.0/255.0, green: 165.0/255.0, blue: 141.0/255.0, alpha:1.0)
    }

    static func getColorFrom(_ color: AppColor) -> UIColor {
        switch color {
        case .blue:
            return .blueCard
        case .lightBlue:
            return .lightBlueCard
        case .orange:
            return .orangeCard
        case .pink:
            return .pinkCard
        case .yellow:
            return .yellowCard
        case .red:
            return .redCard
        }
    }
}

public enum AppColor: String {
    case red
    case orange
    case blue
    case pink
    case yellow
    case lightBlue

    public static func getRandom() -> AppColor {
        let arr: [AppColor] = [.red, .orange, .blue, .pink, .yellow, .lightBlue]
        if let color = arr.randomElement() {
            return color
        }
        return .pink
    }
}
