//
//  CalendarModule.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 26/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class CalendarModuleController: UIViewController {

    @IBOutlet weak var txtDate: SlashedTextField!
    @IBOutlet weak var hourView: CalendarModuleHourView!

    @IBAction func hourTap(_ sender: UIButton) {
        if sender.currentImage == #imageLiteral(resourceName: "Remove") {
            hourView.isHidden = true
            sender.setImage(#imageLiteral(resourceName: "Plus"), for: .normal)
            sender.setTitle("Adicionar horário".localized(), for: .normal)
            sender.setTitleColor(UIColor(named: "Action Color"), for: .normal)
        } else {
            hourView.isHidden = false
            sender.setImage(#imageLiteral(resourceName: "Remove"), for: .normal)
            sender.setTitle("Remover horário".localized(), for: .normal)
            sender.setTitleColor(UIColor(named: "Remove Color"), for: .normal)
        }
    }
    
}
