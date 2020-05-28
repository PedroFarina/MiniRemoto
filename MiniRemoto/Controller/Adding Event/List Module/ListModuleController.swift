//
//  AddListViewController.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 20/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class ListModuleViewController: UIViewController, ModuleController {
    var module: Module?
    var reloadData: (() -> Void)?


    @IBOutlet weak var placeHolderAddListTip: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCheck: UIButton!
    
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!

    var addListTableViewDataSource: ListModuleTableDataSource?
    var addListTableViewDelegate: ListModuleTableDelegate?
    var shouldBeginCalledBeforeHand: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        hideKeyboardWhenTappedAround()
    }

    func setupTableView() {
        addListTableViewDataSource = ListModuleTableDataSource(txtFieldDelegate: self)
        addListTableViewDelegate = ListModuleTableDelegate(tableViewHeight: tableViewHeight)
        listTableView.dataSource = addListTableViewDataSource
        listTableView.delegate = addListTableViewDelegate
        
        btnCheck.isHidden = true
        btnSave.isEnabled = false
    }

    func addRow() {
        let row = addListTableViewDataSource?.numberOfRows ??  0
        let index = IndexPath(row: row, section: 0)
        addListTableViewDataSource?.addRow(in: listTableView, at: index)
        tableViewHeight.constant += 28
    }
    func getAllListItems(){
        var allUITextFieldsItems:[UITextField] = []
        allUITextFieldsItems.append(contentsOf: addListTableViewDataSource!.texts)
        
        allUITextFieldsItems.forEach { (allTextsItems) in
            if let text = allTextsItems.text {
                if text != "" {
                    print(text)
                }
            }
        }
       }

    
    @IBAction func addItemButton(_ sender: Any) {
        addRow()
        placeHolderAddListTip.text = ""
    }
    
    @IBAction func confirmarButton(_ sender: Any) {
        getAllListItems()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension ListModuleViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addRow()
        return false
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        shouldBeginCalledBeforeHand = true
        return shouldBeginCalledBeforeHand
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            btnCheck.isHidden = false
            btnSave.isEnabled = true
        }
        return shouldBeginCalledBeforeHand
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        shouldBeginCalledBeforeHand = false
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        shouldBeginCalledBeforeHand = true
        view.endEditing(true)
    }
}
