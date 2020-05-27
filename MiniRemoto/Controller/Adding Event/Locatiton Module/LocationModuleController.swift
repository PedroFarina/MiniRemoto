//
//  LocationModuleController.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 27/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class LocationModuleController: UIViewController, UITextFieldDelegate, ModuleController {
    public var module: Module?
    public var reloadData: (() -> Void)?


    @IBOutlet weak var addressTableView: UITableView!
    private let tableDataSource = AddressTableDataSource()
    private let tableDelegate = AddressTableDelegate()

    @IBOutlet weak var addressTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var txtAddress: SlashedTextField!

    public override func viewDidLoad() {
        addressTableView.dataSource = tableDataSource
        addressTableView.delegate = tableDelegate
        addressTableView.tableFooterView = UIView()

        txtAddress.delegate = self
        txtAddress.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }

    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        tableDataSource.searchForAddress(text) { (results) in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) {
                    self.addressTableView.reloadData()
                    self.addressTableViewHeight.constant = CGFloat(56 * results)
                }
            }
        }
    }
}
