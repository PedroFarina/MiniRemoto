//
//  AddListViewController.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 20/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class ListModuleViewController: UIViewController, ModuleController {

    @IBOutlet weak var placeHolderAddListTip: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var tbBottomConstraint: NSLayoutConstraint!
    var tbBottomConstant: CGFloat = 0.0

    var addListTableViewDataSource: ListModuleTableDataSource?
    var addListTableViewDelegate: ListModuleTableViewDelegate?
    var shouldBeginCalledBeforeHand: Bool = false
    var module: Module?
    var reloadData: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func setupTableView() {
       
        tbBottomConstant = tbBottomConstraint.constant
        addListTableViewDataSource = ListModuleTableDataSource(txtFieldDelegate: self)
        addListTableViewDelegate = ListModuleTableViewDelegate(view: self.view)
        listTableView.dataSource = addListTableViewDataSource
        listTableView.delegate = addListTableViewDelegate
        btnCheck.isHidden = true
        btnSave.isEnabled = false
    }

    func addRow() {
        let row = addListTableViewDataSource?.numberOfRows ??  0
        let index = IndexPath(row: row, section: 0)
        addListTableViewDataSource?.addRow(in: listTableView, at: index)
        listTableView.scrollToRow(at: index, at: .bottom, animated: false)
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

    func animateTableView(constant: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.tbBottomConstraint.constant = constant
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            animateTableView(constant: keyboardHeight)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        animateTableView(constant: tbBottomConstant)
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
        shouldBeginCalledBeforeHand = false
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        shouldBeginCalledBeforeHand = true
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
