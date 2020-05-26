//
//  CalendarModule.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 26/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class CalendarModuleController: UIViewController, UITextFieldDelegate {

    let toolbar = UIToolbar()
    let picker = UIDatePicker()
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"

        return df
    }()
    let hourFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "hh:mm"

        return df
    }()
    @IBOutlet weak var txtDate: SlashedTextField!
    @IBOutlet weak var hourView: CalendarModuleHourView!

    public override func viewDidLoad() {
        txtDate.delegate = self
        hourView.txtStarts.delegate = self
        hourView.txtEnds.delegate = self

        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(toolbarDoneTap))
        toolbar.setItems([doneBtn], animated: false)
    }

    @IBAction func hourTap(_ sender: UIButton) {
        if sender.currentImage == #imageLiteral(resourceName: "Remove") {
            hourView.isHidden = true
            hourView.startText = nil
            hourView.endText = nil
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

    weak var currentTextField: UITextField?
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
        textField.inputAccessoryView = toolbar
        if textField == txtDate {
            picker.datePickerMode = .date
        } else {
            picker.datePickerMode = .time
        }
        picker.date = Date()
        textField.inputView = picker
    }

    @objc func toolbarDoneTap() {
        currentTextField?.endEditing(true)
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtDate {
            textField.text = dateFormatter.string(from: picker.date)
        } else {
            textField.text = hourFormatter.string(from: picker.date)
        }
        currentTextField = nil
        return true
    }
}
