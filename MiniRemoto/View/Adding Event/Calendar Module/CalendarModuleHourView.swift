//
//  CalendarModuleHourView.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 26/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class CalendarModuleHourView: UIView {
    @IBOutlet weak var txtStarts: SlashedTextField!
    public var startText: String? {
        get {
            return txtStarts.text
        }
        set {
            txtStarts.text = newValue
        }
    }
    @IBOutlet weak var txtEnds: SlashedTextField!
    public var endText: String? {
        get {
            return txtEnds.text
        }
        set {
            txtEnds.text = newValue
        }
    }
}
