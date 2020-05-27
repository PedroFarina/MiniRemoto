//
//  LocationModuleController.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 27/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
import MapKit

public class LocationModuleController: UIViewController, UITextFieldDelegate, ModuleController, AddressSelectedDelegate {


    @IBOutlet weak var btnSave: UIButton!
    private func checkSave() {
        btnSave.isEnabled = address != nil
    }

    public var reloadData: (() -> Void)?
    public var module: Module?
    private var address: MKMapItem?

    @IBOutlet weak var addressTableView: UITableView!
    private let tableDataSource = AddressTableDataSource()
    private let tableDelegate = AddressTableDelegate()

    @IBOutlet weak var addressTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var txtAddress: SlashedTextField!
    @IBOutlet weak var txtAddress2: SlashedTextField!
    
    public override func viewDidLoad() {
        addressTableView.dataSource = tableDataSource
        addressTableView.delegate = tableDelegate
        tableDelegate.delegate = self
        addressTableView.tableFooterView = UIView()

        txtAddress.delegate = self
        txtAddress2.delegate = self
        txtAddress.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtAddress {
            address = nil
        }
        return true
    }

    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        tableDataSource.searchForAddress(text) { (results) in
            DispatchQueue.main.async {
                self.addressTableView.reloadData()
                self.addressTableViewHeight.constant = CGFloat(56 * results)
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtAddress && address == nil {
            textField.text = ""
        }
        self.addressTableViewHeight.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        checkSave()
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    public func didSelect(address: MKMapItem) {
        self.address = address
        txtAddress.text = address.name
        txtAddress.endEditing(true)
    }
}
