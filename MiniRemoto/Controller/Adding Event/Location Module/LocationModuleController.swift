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

        guard let locationModule = module as? LocationData else {
            return
        }
        address = locationModule.location
        txtAddress.text = locationModule.location?.placemark.name
        txtAddress2.text = locationModule.addressLine2
        checkSave()
    }

    var lockSuggestion = false
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        lockSuggestion = false
    }

    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        checkSave()
        address = nil
        tableDataSource.searchForAddress(text) { (results) in
            if self.lockSuggestion { return }
            DispatchQueue.main.async {
                self.addressTableView.reloadData()
                self.addressTableViewHeight.constant = CGFloat(56 * results)
                UIView.animate(withDuration: 0.4) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        lockSuggestion = true
        if textField == txtAddress && address == nil {
            textField.text = ""
        }
        self.addressTableViewHeight.constant = 0
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
        checkSave()
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let index = IndexPath(item: 0, section: 0)
        if addressTableView.cellForRow(at: index) != nil {
            addressTableView.selectRow(at: index, animated: true, scrollPosition: .top)
            tableDelegate.tableView(addressTableView, didSelectRowAt: index)
        }
        textField.resignFirstResponder()
        return true
    }

    public func didSelect(address: MKMapItem) {
        self.address = address
        txtAddress.text = address.name
        view.endEditing(true)
    }

    @IBAction func cancelTap(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func saveTap(_ sender: Any) {
        guard let data = module as? LocationData else {
            fatalError("Module was not Location Data")
        }
        data.location = address
        data.addressLine2 = txtAddress2.text
        reloadData?()
        self.dismiss(animated: true)
    }
}
