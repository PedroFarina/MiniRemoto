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
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var bottomValue: CGFloat = 0.0
    var addListTableViewDataSource: ListModuleTableDataSource?
    var shouldBeginCalledBeforeHand: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        hideKeyboardWhenTappedAround()
        bottomValue = bottomConstraint.constant

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func setupTableView() {
        addListTableViewDataSource = ListModuleTableDataSource(txtFieldDelegate: self)
        listTableView.dataSource = addListTableViewDataSource
        
        btnCheck.isHidden = true
        btnSave.isEnabled = false
    }

    func addRow() {
        checkRowCount()
        let row = addListTableViewDataSource?.numberOfRows ??  0
        let index = IndexPath(row: row, section: 0)
        addListTableViewDataSource?.addRow(in: listTableView, at: index)
        listTableView.scrollToRow(at: index, at: .bottom, animated: true)
    }

    func animate(constant: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.bottomConstraint.constant = constant
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeigh = keyboardSize.height
            animate(constant: keyboardHeigh)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        animate(constant: bottomValue)
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
        guard let rows = addListTableViewDataSource?.numberOfRows else {return}
        if rows <= 12 {
            addRow()
        }
    }
    
    @IBAction func okBtnAction(_ sender: Any) {
        getAllListItems()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkBtnAction(_ sender: Any) {
        getAllListItems()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func checkRowCount() {
        guard let rows = addListTableViewDataSource?.numberOfRows else {return}
        if rows >= 12 {
            let alert = UIAlertController(title: "Alerta", message: "O número máximo de itens nessa lista é \(rows)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ListModuleViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let rows = addListTableViewDataSource?.numberOfRows else {return false}

        if rows <= 12 {
            addRow()
        }

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

