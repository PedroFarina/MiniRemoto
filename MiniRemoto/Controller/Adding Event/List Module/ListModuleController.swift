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
    @IBOutlet weak var tbBottomConstraint: NSLayoutConstraint!
    var bottomConstraint: CGFloat = 0.0

    var shouldBeginCalledBeforeHand: Bool = false
    var textsFields: [UITextField] = []
    var texts: [String] = []
    var rows: Int = 0
    let identifier: String = "AddListTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.setContentOffset(.zero, animated: true)
        bottomConstraint = tbBottomConstraint.constant
        btnCheck.isHidden = true
        hideKeyboardWhenTappedAround()
        print("AAAAAA")

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidHide),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }
    
    func getAllListItems(){
         var allUITextFieldsItems:[UITextField] = []
         allUITextFieldsItems.append(contentsOf: textsFields)
         allUITextFieldsItems.forEach { (allTextsItems) in
             if let text = allTextsItems.text {
                 print(text)
             }
         }
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            animateTableView(constant: keyboardHeight)
        }
    }

    @objc func keyboardDidHide(_ notification: Notification) {
        animateTableView(constant: bottomConstraint)
    }

    func animateTableView(constant: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.tbBottomConstraint.constant = constant
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func addItemButton(_ sender: Any) {
        addRow()
    }
    
    @IBAction func okBtnAction(_ sender: Any) {
        //getAllListItems()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkBtnAction(_ sender: Any) {
        //getAllListItems()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension ListModuleViewController: UITableViewDataSource, UITableViewDelegate {

    func addRow() {
        placeHolderAddListTip.isHidden = true
        listTableView.beginUpdates()
        texts.append("")
        var indexPath = IndexPath()
        indexPath = IndexPath(row: rows, section: 0)
        rows += 1
        listTableView.insertRows(at: [indexPath], with: .bottom)
        listTableView.endUpdates()
        listTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellForRow = tableView.dequeueReusableCell(withIdentifier: identifier) as? ListModuleTableViewCell
        guard let cell = cellForRow else { return UITableViewCell() }

        cell.setup(with: self)
        textsFields.append(cell.txtItem)

        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        shouldBeginCalledBeforeHand = true
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
        texts.append(textField.text ?? "")
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
        shouldBeginCalledBeforeHand = false
        view.endEditing(true)
    }
}

