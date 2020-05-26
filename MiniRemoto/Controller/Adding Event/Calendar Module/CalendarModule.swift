//
//  CalendarModule.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 26/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class CalendarModuleController: UIViewController, UITextFieldDelegate, ModuleController {

    @IBOutlet weak var btnSave: UIButton!
    private func checkSave() {
        btnSave.isEnabled = !(txtDate.text ?? "").isEmpty && ((!(hourView.startText ?? "").isEmpty && !(hourView.endText ?? "").isEmpty) || hourView.isHidden)
    }
    @IBOutlet weak var btnHour: UIButton!

    public weak var tableView: UITableView?
    public weak var module: Module?
    let toolbar = UIToolbar()
    let picker = UIDatePicker()
    let dateFormatter: DateFormatter = DateFormatter()
    @IBOutlet weak var txtDate: SlashedTextField!
    @IBOutlet weak var hourView: CalendarModuleHourView!

    public override func viewDidLoad() {
        txtDate.delegate = self
        hourView.txtStarts.delegate = self
        hourView.txtEnds.delegate = self

        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(toolbarDoneTap))
        toolbar.setItems([doneBtn], animated: false)

        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let module = module as? CalendarData,
            let startDate = module.startDate else {
            return
        }
        let firstDate = dateFormatter.string(from: startDate)
        txtDate.text = firstDate
        if !module.allDay {
            dateFormatter.dateFormat = "hh:mm a"
            hourTap(btnHour)
            let startHour = dateFormatter.string(from: startDate)
            var endHour: String? = nil
            if let endDate = module.endDate {
                endHour = dateFormatter.string(from: endDate)
            }

            hourView.startText = startHour
            hourView.endText = endHour
            checkSave()
        }
    }

    @IBAction func hourTap(_ sender: UIButton) {
        currentTextField?.endEditing(true)
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
        checkSave()
    }

    weak var currentTextField: UITextField?
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
        textField.inputAccessoryView = toolbar
        picker.date = Date()
        picker.minimumDate = nil
        picker.maximumDate = nil
        if textField == txtDate {
            picker.datePickerMode = .date
        } else {
            picker.datePickerMode = .time
            dateFormatter.dateFormat =  "ddMMyyyy"
            let todayString = dateFormatter.string(from: Date())
            dateFormatter.dateFormat = "ddMMyyyy hh:mm a"
            if textField == hourView.txtStarts {
                if let endDate = dateFormatter.date(from: "\(todayString) \(hourView.endText ?? "no")") {
                    picker.maximumDate = endDate
                }
            } else {
                if let startDate = dateFormatter.date(from: "\(todayString) \(hourView.startText ??  "no")") {
                    picker.minimumDate = startDate
                }
            }
        }
        textField.inputView = picker
    }

    @objc func toolbarDoneTap() {
        currentTextField?.endEditing(true)
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtDate {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            textField.text = dateFormatter.string(from: picker.date)
        } else {
            dateFormatter.dateFormat = "hh:mm a"
            textField.text = dateFormatter.string(from: picker.date)
        }
        currentTextField = nil
        checkSave()
        return true
    }


    @IBAction func cancelTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func saveTap(_ sender: Any) {
        guard let data = module as? CalendarData else  {
            fatalError("Module was not Calendar Data")
        }
        data.allDay = hourView.isHidden
        if data.allDay {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            if let date = dateFormatter.date(from: "\(txtDate.text ?? "")") {
                data.startDate = date
            }
        } else {
            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
            if let startDate = dateFormatter.date(from: "\(txtDate.text ?? "") \(hourView.startText ?? "")") {
                data.startDate = startDate
            }
            if let endDate = dateFormatter.date(from: "\(txtDate.text ?? "") \(hourView.endText ?? "")") {
                data.endDate = endDate
            }
        }
        tableView?.reloadData()
        self.dismiss(animated: true)
    }
}
